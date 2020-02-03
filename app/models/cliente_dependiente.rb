class ClienteDependiente < ApplicationRecord
    validates :cuil, presence: true
    validates :nombre, presence: true
    validates :codigo_tipo_responsable, presence: true, numericality: { only_integer: true, 
    greater_than_or_equal_to: 1, less_than_or_equal_to: 14 }
    validates :email, presence: true

    has_many :sells
    has_many :phone_numbers

    validates :phone_numbers, :length => { :minimum => 1 }
end
