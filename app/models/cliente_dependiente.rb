class ClienteDependiente < ApplicationRecord
    validates :cuil, presence: true
    validates :nombre, presence: true
    validates :codigo_tipo_responsable, presence: true
    validates :email, presence: true

    has_many :sells
end
