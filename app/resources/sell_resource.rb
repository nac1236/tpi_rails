class SellResource < JSONAPI::Resource
    attributes :date, :tipo_cliente
    
    has_one :user
    has_many :details
    has_one :cliente_dependiente
    has_one :cliente_autonomo

    filter :cliente_dependiente
    filter :cliente_autonomo
end