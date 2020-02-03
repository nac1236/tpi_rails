class ReservationDetail < ApplicationRecord
    validates :number_of_items, presence: true

    belongs_to :reservation
    belongs_to :product
end
