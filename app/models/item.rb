class Item < ActiveRecord::Base 
# Los posibles estados de un item son: disponible, reservado y vendido.

attribute :state, default: 'disponible'
scope :disponibles, -> { where(state:"disponible") }

belongs_to :product
end
