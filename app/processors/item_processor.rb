class ItemProcessor < JSONAPI::Processor

    def create_resource
        params[:data][:attributes] = { product_id: context[:product_id] }
        data = params[:data]
        items = Array.new
        resource = nil
        result = nil
        if(context[:cantidad] > 0)
            context[:cantidad].times do # crea un solo item
                resource = resource_klass.create(context)
                result = resource.replace_fields(data)
                if(result == :completed)
                    items.push(resource)
                end
            end
        else
            #errors = Array.new
            #errors.push(JSONAPI::Error.new({code: 105}))
            #return JSONAPI::ErrorsOperationResult.new(:param_not_allowed, errors)
            puts "Se debe ingresar un numero mayor que 0"
        end
        items_result = items.each do |item|
            JSONAPI::ResourceSerializer.new(ItemResource).serialize_to_hash(ItemResource.new(item,nil))
        end
        return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), items_result)
    end
end