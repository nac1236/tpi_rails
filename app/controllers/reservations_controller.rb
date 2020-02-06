include SessionsHandling

class ReservationsController < ApplicationController
    before_action :is_authenticated?
    skip_before_action :verify_authenticity_token

    def index
        return unless verify_accept_header

        if(@user)
            reservations = Reservation.where(sold: false)
            if(reservations.size > 0)
                to_serialize = []
                reservations.each do |reservation|
                    date = reservation.created_at
                    client = nil
                    if(reservation.cliente_autonomo_id.nil?)
                        client = ClienteDependiente.find(reservation.cliente_dependiente_id).nombre
                    elsif
                        if(reservation.tipo_cliente == "empresa")
                            client = ClienteAutonomo.find(reservation.cliente_autonomo_id).razon_social
                        else
                            client = ClienteAutonomo.find(reservation.cliente_autonomo_id).nombre
                        end
                    end
                    total = reservation.total
                    data = DateClientTotal.new(date,client,total)
                    to_serialize.push(data)
                end

                serialized_resources = []

                to_serialize.each do |reservation|
                    serialized_resources.push(JSONAPI::ResourceSerializer.new(DateClientTotalResource).object_hash(DateClientTotalResource.new(reservation,nil)))
                end
                render json: {data:serialized_resources}, status: 200
            else
                render json: {}, status: 204
            end
        end
    end

    def show
        return unless verify_accept_header

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