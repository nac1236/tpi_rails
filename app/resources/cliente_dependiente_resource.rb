class ClienteDependienteResource < JSONAPI::Resource
    attributes :cuil, :nombre, :codigo_tipo_responsable, :email

    has_many :sells
    has_many :reservations
end