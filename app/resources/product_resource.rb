class ProductResource < JSONAPI::Resource
    attributes :code, :description, :detail, :cost_per_unit
    
    has_many :items

    paginator :paged
end