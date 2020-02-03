class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.boolean :sold, :default => false

      t.timestamps
    end
  end
end
