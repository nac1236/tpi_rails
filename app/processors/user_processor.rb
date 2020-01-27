class UserProcessor < JSONAPI::Processor
    def create_resource
      data = params[:data]
      puts ("Estos son los datos que entraron " + data.to_s)
      puts context
      resource = resource_klass.create(context)
      result = resource.replace_fields(data)

      return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
      # Esto anda bien --> return JSONAPI::ErrorsOperationResult.new(:forbidden, JSONAPI::Error.new(code: :forbidden))

    end
end