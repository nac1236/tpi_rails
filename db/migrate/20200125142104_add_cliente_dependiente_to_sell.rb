class AddClienteDependienteToSell < ActiveRecord::Migration[6.0]
  def change
    add_reference :sells, :cliente_dependiente, null: true, foreign_key: true
  end
end
