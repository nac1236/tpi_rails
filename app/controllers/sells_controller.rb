class SellsController < JSONAPI::ResourceController
    include SessionsHandling
    before_action :is_authenticated?

    skip_before_action :verify_authenticity_token

    def index
        return unless verify_accept_header

        if(@user)
            sells = Sell.where(user_id: @user.id)
            if(sells.size > 0)
                to_serialize = []
                sells.each do |sell|
                    date = sell.created_at
                    client = nil
                    if(sell.cliente_autonomo_id.nil?)
                        client = ClienteDependiente.find(sell.cliente_dependiente_id).nombre
                    elsif
                        if(sell.tipo_cliente == "empresa")
                            client = ClienteAutonomo.find(sell.cliente_autonomo_id).razon_social
                        else
                            client = ClienteAutonomo.find(sell.cliente_autonomo_id).nombre
                        end
                    end
                    total = sell.total
                    sct = DateClientTotal.new(date,client,total)
                    to_serialize.push(sct)
                end

                serialized_resources = []

                to_serialize.each do |sell|
                    serialized_resources.push(JSONAPI::ResourceSerializer.new(DateClientTotalResource).object_hash(DateClientTotalResource.new(sell,nil)))
                end
                render json: {data:serialized_resources}, status: 200
            else
                render json: {}, status: 204
            end
        end
    end

    def show
        return unless verify_accept_header
        
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
