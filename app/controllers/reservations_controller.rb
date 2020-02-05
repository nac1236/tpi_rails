include SessionsHandling

class ReservationsController < ApplicationController
    before_action :is_authenticated?
    skip_before_action :verify_authenticity_token

    def show
        if(params[:include])
            id = params[:id]
            reservation = Reservation.find(id)
            serialized_resources = []
            if(params[:include] == "items")
                items = Item.find_by(reservation_id:id)
                serialized_resources.push(JSONAPI::ResourceSerializer.new(ItemResource).serialize_to_hash(ItemResource.new(items,nil)))
            end
            if(params[:include] == "sell")
                sell = Sell.find(reservation.sell_id)
                serialized_resources.push(JSONAPI::ResourceSerializer.new(SellResource).serialize_to_hash(SellResource.new(sell,nil)))
            end
            serialized_reservation = JSONAPI::ResourceSerializer.new(ReservationResource).serialize_to_hash(ReservationResource.new(reservation,nil))
            serialized_reservation[:include] = serialized_resources
            render json: serialized_reservation, status: 200
        else
            process_request
        end
    end
    

    def context
        {
            user: @user,
            data: params
        }
    end

end