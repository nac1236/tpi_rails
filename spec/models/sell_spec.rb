require 'rails_helper'

RSpec.describe Sell, type: :model do
  context "validations" do
    User.new(username:"user1", password:"12345").save
    it "ensures tipo_cliente presence" do
      sell = Sell.new(user_id: User.first.id).save
      expect(sell).to eq(false)
    end

    it "should create a sell" do
      sell = Sell.new(tipo_cliente:"persona", user_id: User.first.id).save
      expect(sell).to eq(true)
    end

  end
end
