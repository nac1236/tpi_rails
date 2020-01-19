class ItemResource < JSONAPI::Resource
    attributes :state
    has_one :product
  
    filter :product
  end