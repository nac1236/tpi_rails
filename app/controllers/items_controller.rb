class ItemsController < JSONAPI::ResourceController
    include SessionsHandling
    before_action :is_authenticated?

    skip_before_action :verify_authenticity_token

    def context
        {
            data: params
        }
    end 

end
