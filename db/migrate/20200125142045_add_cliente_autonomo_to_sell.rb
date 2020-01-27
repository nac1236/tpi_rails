class AddClienteAutonomoToSell < ActiveRecord::Migration[6.0]
  def change
    add_reference :sells, :cliente_autonomo, null: true, foreign_key: true
  end
end
