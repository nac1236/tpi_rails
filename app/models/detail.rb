class Detail < ApplicationRecord
    validates :number_of_items, presence: true

    belongs_to :sell
    belongs_to :product
end
