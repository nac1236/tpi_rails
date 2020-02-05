class Reservation < ApplicationRecord

    has_many :reservation_details
    belongs_to :user
    belongs_to :cliente_dependiente, required: false, default: nil
    belongs_to :cliente_autonomo, required: false, default: nil
    has_many :items
    has_one :sell
end
