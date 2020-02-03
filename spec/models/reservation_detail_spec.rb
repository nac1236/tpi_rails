require 'rails_helper'

RSpec.describe ReservationDetail, type: :model do
  context "validations" do

    User.new(username:"user16", password:"12345").save
    Product.new(code:'asd456456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
    Reservation.new(user_id: User.first.id).save

    it "ensures number_of_items presence" do
      r_detail = ReservationDetail.new(product_id: Product.first.id, reservation_id: Reservation.first.id).save
      expect(r_detail).to eq(false)
      r_detail = ReservationDetail.new(number_of_items:2, product_id: Product.first.id, reservation_id: Reservation.first.id).save
      expect(r_detail).to eq(true)
    end

  end
end
