class ClienteAutonomo < ApplicationRecord
    validates :cuit, presence: true 
    validates :razon_social, presence: true, if: :empresa?
    validates :nombre, presence: true, if: :persona_fisica?
    validates :codigo_tipo_responsable, presence: true
    validates :email, presence: true
    validates :tipo_cliente, presence: true

    def persona_fisica?
        tipo_cliente == "persona"
    end

    def empresa?
        tipo_cliente == "empresa"
    end

    has_many :sells
    has_many :reservations

    has_many :phone_numbers

    validates :phone_numbers, :length => { :minimum => 1 }
end
