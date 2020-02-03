class Sell < ApplicationRecord
    validates :tipo_cliente, presence: true

    has_many :details
    belongs_to :user
    belongs_to :cliente_dependiente, required: false, default: nil
    belongs_to :cliente_autonomo, required: false, default: nil
    has_many :items
end
