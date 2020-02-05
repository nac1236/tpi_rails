include DetailsHandling

class SellProcessor < JSONAPI::Processor

    def create_resource
      if(!context[:user].nil?)
        params[:data][:attributes][:date] = Time.now
        data = params[:data]
        resource = resource_klass.create(context)
        result = resource.replace_fields(data)
  
        create_details_for(resource.id)
        
        return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
      end
    end

    def add_item_for_product(id,cantidad,to_store,price_per_unit)   
      # Actualiza los items una vez que estan creados los detalles
      items = Item.where(["product_id = ? AND state = ?", id, "disponible"]).first(cantidad)
      items.each do |item|
        item.sell_id = id 
        item.state = 'vendido'
        item.sold_price = price_per_unit
        to_store.push(item)
      end
   end

    def add_detail(id,cantidad, product_id, details)
      details.push(Detail.new(product_id: product_id, number_of_items: cantidad,sell_id: id ))
    end

    def update_items(to_store,id)
      to_store.each do |item|
        Item.where("id = ?",item.id).update(state: item.state, sold_price: item.sold_price, sell_id: id)
      end
    end

    def save_total(id,total)
      Sell.where("id = ?",id).update(total: total)
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

            # Probando como devolver los datos que se recuperan
            puts (" \n\n\n Esto es lo que hay en resource records: " + resource_records.to_s + "\n\n\n")
            #puts resource_records.class
            data = Array.new
            # Cada elemento de resource records tiene una venta
            #puts resource_records.first().date()
            #puts resource_records.first().class --> SellResource

            # Puedo hacer esto o crear un resource nuevo
            resource_records.each do |sell|
              a_sell = { date: sell.date()}
              a_sell = {total: Sell.find(sell.id).total}
              if (sell.tipo_cliente == "dependiente")
                a_sell = {nombre: ClienteDependiente.find(sell.cliente_dependiente_id).nombre()}
              elsif (sell.tipo_cliente == "autonomo")
                autonomo = ClienteDependiente.find(sell.cliente_autonomo_id)
                if (autonomo.tipo_cliente.persona_fisica?)
                  a_sell = {nombre: autonomo.nombre()}
                else
                  a_sell = {razon_social: autonomo.razon_social()}
                end
              end
              data.push(a_sell)
            end
            puts data
            return JSONAPI::ResourcesOperationResult.new(:ok, resource_records, page_options)
            
        else
            errors = Array.new
            errors.push(JSONAPI::Error.new({code: 403}))
            return JSONAPI::ErrorsOperationResult.new(:forbidden, errors)
        end
    end

end