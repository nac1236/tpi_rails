class ClienteAutonomo < ApplicationRecord
    validates :cuit, presence: true, if: :persona_fisica?
    validates :razon_social, presence: true, if: :empresa?
    validates :nombre, presence: true
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
end
