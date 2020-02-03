class ItemsController < JSONAPI::ResourceController
    #include SessionsHandling
    #before_action :is_authenticated?

    skip_before_action :verify_authenticity_token

    def context
        {
            data: params
            #product_id: params[:product_id],
            #cantidad: params[:meta][:cantidad].to_i
        }
    end 

end
