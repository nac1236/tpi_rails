module DetailsHandling

  def create_details_for(id)
    details = []
    products = context[:data][:meta]      
    to_store = []
    total = 0

    products.each_key do |each|
      product_id = products[each][:product_id]
      cantidad = products[each][:cantidad]
      price_per_unit = Product.find(product_id).cost_per_unit
      total = total + price_per_unit * cantidad
      result = evaluate_details_creation(product_id,cantidad)
      if result
        add_item_for_product(product_id,cantidad,to_store,price_per_unit)
        # La clase que incluya este modulo debe implementar add_detail()
        add_detail(id,cantidad, product_id, details)
      else
        #rollback --> No se puede crear el detalle para determinado producto.
        return false
      end
      save_total(id,total)
      save_details(details)
      update_items(to_store,id)
    end
  end

  def evaluate_details_creation(id, cantidad)
      product ||= Product.find(id)
          if (!product.nil?)
            if(product.items().disponibles().count() >= cantidad)
              puts "Hay la cantidad necesaria"
              return true
            else
              puts "La cantidad de productos no es suficiente"
              return false
            end
          else
            puts "No existe el producto con ese id."
            return false
          end
    end

    def save_details(details)
      # Almacena detalles
      details.each do |detail|
        detail.save()
      end
    end

    def update_items(to_store,id)
      to_store.each do |item|
        Item.where("id = ?",item.id).update(state: item.state, sold_price: item.sold_price, reservation_id: id)
      end
    end

end