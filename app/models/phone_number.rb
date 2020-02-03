class PhoneNumber < ApplicationRecord
    validates :number, presence: true

    belongs_to :cliente_dependiente, required: false, default: nil
    belongs_to :cliente_autonomo, required: false, default: nil
end
