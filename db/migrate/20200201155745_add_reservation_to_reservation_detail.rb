class AddReservationToReservationDetail < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservation_details, :reservation, null: false, foreign_key: true
  end
end
