require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    product = Product.new(code:'qwe123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
    it "ensures state presence" do
      item = Item.new(product_id: Product.first.id).save
      expect(item).to eq(false)
      item = Item.new(state:"disponible", product_id: Product.first.id).save
      expect(item).to eq(true)
    end

    it "ensures product presence" do
      item = Item.new(state:"disponible").save
      expect(item).to eq(false)
    end

  end

  context "scopes" do

    product = Product.new(code:'qwe123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save

    it "should return items with state disponible" do
      Item.new(state:"disponible", product_id: Product.first.id).save
      Item.new(state:"reservado", product_id: Product.first.id).save
      Item.new(state:"vendido", product_id: Product.first.id).save
      Item.new(state:"disponible", product_id: Product.first.id).save
      expect(Item.disponibles.size).to eq(2)
    end

  end

end
