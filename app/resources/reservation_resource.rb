class ReservationResource < JSONAPI::Resource
    attributes :sold
    
    has_one :user
    has_many :reservation_details
    has_one :cliente_dependiente
    has_one :cliente_autonomo

    filter :cliente_dependiente
    filter :cliente_autonomo
end