class ReservationDetailResource < JSONAPI::Resource
    attributes :number_of_items
    has_one :product
    has_one :reservation
    
    filter :reservation
end