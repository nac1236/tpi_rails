class SellsController < JSONAPI::ResourceController
    include SessionsHandling
    before_action :is_authenticated?

    skip_before_action :verify_authenticity_token

    def context
        {
            user: @user,
            data: params
        }
    end
end
