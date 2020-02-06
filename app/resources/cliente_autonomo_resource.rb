class ClienteAutonomoResource < JSONAPI::Resource
    attributes :cuit

    has_many :sells
    has_many :reservations
end