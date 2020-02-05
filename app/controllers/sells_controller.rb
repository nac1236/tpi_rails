class SellsController < JSONAPI::ResourceController
    include SessionsHandling
    before_action :is_authenticated?

    skip_before_action :verify_authenticity_token

    def show
        if(@user)
            id = params[:id]
            sell = Sell.find(id)
            if (@user.id == sell.user_id)
                if(params[:include])
                    serialized_resources = []
                    if(params[:include] == "items")
                        items = Item.find_by(sell_id:id)
                        serialized_resources.push(JSONAPI::ResourceSerializer.new(ItemResource).serialize_to_hash(ItemResource.new(items,nil)))
                    end
                    serialized_sell = JSONAPI::ResourceSerializer.new(SellResource).serialize_to_hash(SellResource.new(sell,nil))
                    serialized_sell[:include] = serialized_resources
                    render json: serialized_sell, status: 200
                else
                    process_request
                end
            else
                render json: JSONAPI::ErrorsOperationResult.new(404, JSONAPI::Error.new(title: "Not found."))
            end
        end
    end 



    def context
        {
            user: @user,
            data: params
        }
    end
end
