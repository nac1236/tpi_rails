class ClienteAutonomoResource < JSONAPI::Resource
    attributes :cuit

    has_many :sells
end