class DetailResource < JSONAPI::Resource
    attributes :number_of_items
    has_one :product
    has_one :sell
    
    filter :sell
end