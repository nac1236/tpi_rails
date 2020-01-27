class SellResource < JSONAPI::Resource
    #faltan atributos
    attributes :date
    
    has_many :details
end