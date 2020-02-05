class AddSellToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :sell, null: true, foreign_key: true
  end
end
