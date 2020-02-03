class ProductProcessor < JSONAPI::Processor

    def find
        if(!context[:user].nil?)

            filters = params[:filters]
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
        
            resources = if params[:cache_serializer]
              resource_klass.find_serialized_with_caching(verified_filters,
                                                          params[:cache_serializer],
                                                          find_options)
            else
              resource_klass.find(verified_filters, find_options)
            end

            resource_records = []

            if (context[:data][:q] == 'in_stock')   
                resources.each do |product|
                    if(product.items.disponibles.count() > 0)
                        resource_records.push(product)
                    end
                end
            elsif (context[:data][:q] == 'scarce') 
                resources.each do |product|
                    #if(1 <= product.items.disponibles.count() and product.items.disponibles.count() <= 5)
                    if(1 <= Product.find(product.id).items.disponibles.count() and Product.find(product.id).items.disponibles.count() <= 5)
                        resource_records.push(product)
                    end
                end
            elsif (context[:data][:q] == 'all') 
                resource_records = resources
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
            puts "No estas logueado. \n\n\n"
            #errors = Array.new
            #errors.push(JSONAPI::Error.new({code: 403}))
            #return JSONAPI::ErrorsOperationResult.new(:forbidden, errors)
        end
    end

end
