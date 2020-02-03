class Item < ActiveRecord::Base 
# Los posibles estados de un item son: disponible, reservado y vendido.

    attribute :state, default: "disponible", presence: true
    attribute :sold_price, default: nil
    scope :disponibles, -> { where(state:"disponible") }

    belongs_to :product, required: true
    belongs_to :sell, default: nil, required: false
    belongs_to :reservation, default: nil, required: false
end
