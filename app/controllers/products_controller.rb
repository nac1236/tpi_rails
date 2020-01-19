class ProductsController < JSONAPI::ResourceController

    def index
        # use params[:nombre_del_parametro], para recuperar el valor
        @products = Product.all()
        puts @products.class()
        if (params[:q] == 'in_stock')
            stock = Array.new   
            @products.each do |product|
                if(product.items.disponibles.count() > 0)
                    stock.push(product)
                end
            end
            render json:serialize_product(stock)
        elsif
            (params[:q] == 'scarce') 
            scarce = Array.new   
            @products.each do |product|
                if(1 <= product.items.disponibles.count() and product.items.disponibles.count() <= 5)
                    scarce.push(product)
                end
            end
            render json:serialize_product(scarce)
        elsif
            (params[:q] == 'all') 
            render json: serialize_product(@products)
        end
    end

    def serialize_product(products)
        products.each do |product|
            JSONAPI::ResourceSerializer.new(ProductResource).serialize_to_hash(ProductResource.new(product,nil))
        end
      end

end
