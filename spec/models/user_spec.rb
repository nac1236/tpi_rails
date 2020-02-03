require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do

    it "ensures username presence" do
      user = User.new(username:"user1").save
      expect(user).to eq(false)
    end

    it "ensures username uniqueness" do
      user1 = User.new(username:"user10", password:"12345").save
      expect(user1).to eq(true)
      user2 = User.new(username:"user10", password:"12345").save
      expect(user2).to eq(false)
    end

    it "ensures password presence" do
      user = User.new(password:"12345").save
      expect(user).to eq(false)
    end

    it "succesfull user creation" do
      user = User.new(username:"user2", password:"12345").save
      expect(user).to eq(true)
    end

  end

end
