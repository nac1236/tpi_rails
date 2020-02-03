require 'rails_helper'

RSpec.describe ClienteDependiente, type: :model do
  context "validations" do
    # Cliente dependiente base --> ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola")
    it "ensures cuil presence" do
      dependiente = ClienteDependiente.new(nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola").save
      expect(dependiente).to eq(false)
    end

    it "ensures nombre presence" do
      dependiente = ClienteDependiente.new(cuil:"123456789", codigo_tipo_responsable: 1, email: "juan@hola").save
      expect(dependiente).to eq(false)
    end

    it "ensures codigo_tipo_responsable presence" do
      dependiente = ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", email: "juan@hola").save
      expect(dependiente).to eq(false)
    end

    it "codigo_tipo_responsable should be an integer between 1 to 14" do
      dependiente = ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1.3, email: "juan@hola").save
      expect(dependiente).to eq(false)
      dependiente = ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 15, email: "juan@hola").save
      expect(dependiente).to eq(false)
    end

    it "ensures email presence" do
      dependiente = ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1).save
      expect(dependiente).to eq(false)
    end

    it "creates a cliente_dependiente" do
      tmp = ClienteDependiente.new(cuil:"123456789", nombre:"Juan Perez", codigo_tipo_responsable: 1, email: "juan@hola")
      tmp.phone_numbers.new(number:"4602222").save
      dependiente = tmp.save
      expect(dependiente).to eq(true)
    end

  end

end
