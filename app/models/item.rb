class Item < ActiveRecord::Base 
# Los posibles estados de un item son: disponible, reservado y vendido.

    attribute :state, default: 'disponible'
    attribute :sold_price, default: nil
    scope :disponibles, -> { where(state:"disponible") }

    belongs_to :product
    belongs_to :sell, default: nil, required: false
end
