class Sell < ApplicationRecord
    validates :date, presence: true

    has_many :details
    belongs_to :user
    belongs_to :cliente_dependiente
    belongs_to :cliente_autonomo
end
