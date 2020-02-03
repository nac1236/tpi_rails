require 'rails_helper'

RSpec.describe ClienteAutonomo, type: :model do
  context "validations" do
    # Cliente autonomo base --> ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola", tipo_cliente:"persona")

    it "ensures cuit presence" do
      autonomo = ClienteAutonomo.new(nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola",tipo_cliente:"persona").save
      expect(autonomo).to eq(false)
    end

    it "ensures nombre presence" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", codigo_tipo_responsable: 1, email: "juan@hola", tipo_cliente:"persona").save
      expect(autonomo).to eq(false)
    end

    it "ensures razon social presence" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", codigo_tipo_responsable: 1, email: "empresa1@hola", tipo_cliente: "empresa").save
      expect(autonomo).to eq(false)
    end

    it "ensures codigo_tipo_responsable presence" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", email: "juan@hola", tipo_cliente: "persona").save
      expect(autonomo).to eq(false)
    end

    it "codigo_tipo_responsable should be an integer between 1 to 14" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1.3, email: "juan@hola", tipo_cliente: "persona").save
      expect(autonomo).to eq(false)
      autonomo = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 15, email: "juan@hola", tipo_cliente:"persona").save
      expect(autonomo).to eq(false)
    end

    it "ensures email presence" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, tipo_cliente: "persona").save
      expect(autonomo).to eq(false)
    end

    it "ensures tipo_cliente presence" do
      autonomo = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola").save
    end

    it "creates a cliente_autonomo" do
      tmp = ClienteAutonomo.new(cuit:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola", tipo_cliente:"persona")
      tmp.phone_numbers.new(number:"4602222").save
      autonomo = tmp.save
      expect(autonomo).to eq(true)
    end

  end
end
