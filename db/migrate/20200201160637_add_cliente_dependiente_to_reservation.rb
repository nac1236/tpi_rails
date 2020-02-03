class AddClienteDependienteToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :cliente_dependiente, null: true, foreign_key: true
  end
end
