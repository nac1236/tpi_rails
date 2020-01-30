class SellProcessor < JSONAPI::Processor

    def create_resource
      # Podria usar metodo create_to_many_relationships, para crear la relacion con los detalles
      # Pasos para crear la venta: (solo con detalle, productos e items)
        # Crear venta y if:
        #   para todos: Crear detalle( producto existe y tiene stock suficiente)
        #                   controlar el tema de los items(si falla tambien deberia hacer rollback)
        # sino
        #   la libreria deberia encargarse de realizar rollback
        
      if(!context[:user].nil?)
        #puts context
        #puts params
        params[:data][:attributes] = { user_id: context[:user] }
        params[:data][:attributes][:date] = Time.now
        params[:data][:attributes][:tipo_cliente] = context[:tipo_cliente]['tipo-cliente']
        data = params[:data]
        resource = resource_klass.create(context)
        result = resource.replace_fields(data)
        # asi puedo recuperar el id del resource --> resource.id

        # Inicializacion de las variables
        details = []
        products = context[:data][:meta]      
        to_store = []
        total = 0

        # Reviso que las condiciones esten dadas para cada producto
        products.each_key do |each|
          id = products[each][:product_id]
          cantidad = products[each][:cantidad]
          result = evaluate_details_creation(id,cantidad)
          if result
            #agregar items a modificar
            price_per_unit = Product.find(id).cost_per_unit
            total = total + price_per_unit * cantidad

            # crear los items una vez que estan creados los detalles
            items = Item.find_by(product_id: id, state: 'disponible')
            cantidad.times do
              items.sell_id = id 
              items.state = 'vendido'
              items.sold_price = price_per_unit
              to_store.push(items)
            end
            details.push(Detail.new(product_id: id, number_of_items: cantidad,sell_id: resource.id ))
          else
            #rollback
            return false
          end

          # Almaceno detalles y actualizo los items
          details.each do |detail|
            detail.save()
          end
          to_store.each do |item|
            # Los items se actualizan mal. Ademas falta agregarles la clave de sell.
            Item.update(state: item.state, sold_price: item.sold_price)
          end
        end
        return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
      end
    end

    def evaluate_details_creation(id, cantidad)
      product ||= Product.find(id)
          if (!product.nil?)
            if(product.items().disponibles().count() >= cantidad)
              puts "Hay la cantidad necesaria"
              return true
            else
              puts "La cantidad de productos no es suficiente"
              return false
            end
          else
            puts "No existe el producto con ese id."
            return false
          end
    end

    def find
        if(!context[:user].nil?)

            filtros = {user: [context[:user].id]}
            
            filters = filtros
            include_directives = params[:include_directives]
            sort_criteria = params.fetch(:sort_criteria, [])
            paginator = params[:paginator]
            fields = params[:fields]
      
            verified_filters = resource_klass.verify_filters(filters, context)
            find_options = {
              context: context,
              include_directives: include_directives,
              sort_criteria: sort_criteria,
              paginator: paginator,
              fields: fields
            }
      
            resource_records = if params[:cache_serializer]
              resource_klass.find_serialized_with_caching(verified_filters,
                                                          params[:cache_serializer],
                                                          find_options)
            else
              resource_klass.find(verified_filters, find_options)
            end
      
            page_options = {}
            if (JSONAPI.configuration.top_level_meta_include_record_count ||
              (paginator && paginator.class.requires_record_count))
              page_options[:record_count] = resource_klass.find_count(verified_filters,
                                                                      context: context,
                                                                      include_directives: include_directives)
            end
      
            if (JSONAPI.configuration.top_level_meta_include_page_count && page_options[:record_count])
              page_options[:page_count] = paginator ? paginator.calculate_page_count(page_options[:record_count]) : 1
            end
      
            if JSONAPI.configuration.top_level_links_include_pagination && paginator
              page_options[:pagination_params] = paginator.links_page_params(page_options.merge(fetched_resources: resource_records))
            end
      
            return JSONAPI::ResourcesOperationResult.new(:ok, resource_records, page_options)
            
        else
            errors = Array.new
            errors.push(JSONAPI::Error.new({code: 403}))
            return JSONAPI::ErrorsOperationResult.new(:forbidden, errors)
        end
    end

end