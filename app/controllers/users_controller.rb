class UsersController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token
    #operations_processor =UserProcessor
    #create_operations_processor

    #def create
    #    @user = User.new(username: params[:user][:u],password: params[:user][:p])
    #    if (@user.save)
    #        render :api_json
    #    else
    #       #JSONAPI::Error.new(code: 121)
    #       render :json => {:error => "Username already taken."}, :status => 400
    #    end
#
    #    data = params[:data]
    #    resource = resource_klass.create(context)
    #    result = resource.replace_fields(data)
  #
    #    return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
    #end
end
