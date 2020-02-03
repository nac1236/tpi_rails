require 'rails_helper'

RSpec.describe Detail, type: :model do
  context "validations" do

    User.new(username:"user15", password:"12345").save
    Product.new(code:'asd456456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
    Sell.new(tipo_cliente:"persona", user_id: User.first.id).save

    it "ensures number_of_items presence" do
      detail = Detail.new(product_id: Product.first.id, sell_id: Sell.first.id).save
      expect(detail).to eq(false)
      detail = Detail.new(number_of_items:2, product_id: Product.first.id, sell_id: Sell.first.id).save
      expect(detail).to eq(true)
    end

  end
end
