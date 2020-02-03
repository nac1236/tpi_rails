class AddClienteAutonomoToPhoneNumber < ActiveRecord::Migration[6.0]
  def change
    add_reference :phone_numbers, :cliente_autonomo, null: true, foreign_key: true
  end
end
