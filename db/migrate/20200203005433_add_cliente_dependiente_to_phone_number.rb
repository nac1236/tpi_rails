class AddClienteDependienteToPhoneNumber < ActiveRecord::Migration[6.0]
  def change
    add_reference :phone_numbers, :cliente_dependiente, null: true, foreign_key: true
  end
end
