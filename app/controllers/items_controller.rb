class ItemsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def create
        puts params[:data]['attributes']['cantidad']
        
        @product = Product.find(params[:product_id])
        @product.items
    end

end
