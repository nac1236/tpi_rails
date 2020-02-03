class AddTotalToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :total, :decimal
  end
end
