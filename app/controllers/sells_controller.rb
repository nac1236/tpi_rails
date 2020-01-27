class SellsController < JSONAPI::ResourceController
    include SessionsHandling
    before_action :is_authenticated?

    def context
        {user: @user}
    end
end
