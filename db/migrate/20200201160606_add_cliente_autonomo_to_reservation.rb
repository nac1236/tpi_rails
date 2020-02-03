class AddClienteAutonomoToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :cliente_autonomo, null: true, foreign_key: true
  end
end
