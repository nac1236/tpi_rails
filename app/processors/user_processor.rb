class UserProcessor < JSONAPI::Processor
    def create_resource
      data = params[:data]
      resource = resource_klass.create(context)
      result = resource.replace_fields(data)

      return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
    end
end