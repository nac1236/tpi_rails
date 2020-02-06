include DetailsHandling

class ReservationProcessor < JSONAPI::Processor
    
    def create_resource
        if(!context[:user].nil?)
          params[:data][:user_id] = context[:user].id
          data = params[:data]
          resource = resource_klass.create(context)
          result = resource.replace_fields(data)
          create_details_for(resource.id)
          return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource)
        else
            puts "No estas logueado."
        end
    end

    def add_item_for_product(id,cantidad,to_store,price_per_unit)   
        items = Item.where(["product_id = ? AND state = ?", id, "disponible"]).first(cantidad)
        items.each do |item|
          item.sell_id = id 
          item.state = 'reservado'
          item.sold_price = price_per_unit
          to_store.push(item)
        end
     end

    def add_detail(id, cantidad, product_id, details)
        details.push(ReservationDetail.new(product_id: product_id, number_of_items: cantidad,reservation_id: id ))
    end

    def save_total(id,total)
        Reservation.where("id = ?",id).update(total: total)
    end

    def remove_resource
    
        if(!context[:user].nil?)
            resource_id = params[:resource_id]
    
            resource = resource_klass.find_by_key(resource_id, context: context)
            if(resource.sold == false)
                remove_items(resource.id)
                remove_details(resource.id)
                result = resource.remove

                return JSONAPI::OperationResult.new(result == :completed ? :no_content : :accepted)
            else
                puts "No se puede borrar una reserva una vez que se realizo la venta."
            end       
        end
    end

    def remove_items(resource_id)
        items = Item.where("reservation_id = ? ", resource_id)
        items.each do |item|
            Item.update(reservation_id: nil, state: "disponible")
        end
    end

    def remove_details(resource_id)
        details = ReservationDetail.where("reservation_id = ?", resource_id)
        details.each do |detail|
            ReservationDetail.delete(detail.id)
        end
    end

    def replace_fields
        if(!context[:user].nil?)
            resource_id = params[:resource_id]
            params[:data][:attributes][:sold] = true
            data = params[:data]
            resource = resource_klass.find_by_key(resource_id, context: context)
            if(resource.sold == false)
                                
                sell = nil

                reservation = Reservation.find(resource_id)

                if(!resource.cliente_dependiente_id == nil)
                    sell = Sell.new(user_id: resource.user_id, cliente_dependiente_id: 
                    resource.cliente_dependiente_id,tipo_cliente: "dependiente", 
                    total:reservation.total)
                else
                    sell = Sell.new(user_id: resource.user_id, cliente_autonomo_id: 
                    resource.cliente_dependiente_id,tipo_cliente: "autonomo", 
                    total:reservation.total)
                end

                sell.save()
                sell_id = Sell.last.id
           
                details = []
                items = []
                reservation_details = reservation.reservation_details()
                reservation_items = reservation.items()
        
                reservation_items.each do |item|
                    item.sell_id = sell_id
                    item.state = 'vendido'
                    items.push(item)
                end

                reservation_details.each do |r_detail|
                    details.push(Detail.new(product_id: r_detail.product_id, number_of_items: r_detail.number_of_items,sell_id: sell_id ))
                end

                details.each do |detail|
                    detail.save()
                end
               
                items.each do |item|
                    Item.where("id = ?",item.id).update(state: item.state, sell_id: sell_id)
                end
                resource.sell_id = sell_id
                result_reservation = resource.replace_fields(data)
            end
            return JSONAPI::ResourceOperationResult.new(result == :completed ? :ok : :accepted, resource)
        end
    end

end