class ItemResource < JSONAPI::Resource
    attributes :state
    # faltan atributos
    has_one :product

    filter :product
  end