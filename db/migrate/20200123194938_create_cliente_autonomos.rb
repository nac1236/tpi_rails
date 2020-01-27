class CreateClienteAutonomos < ActiveRecord::Migration[6.0]
  def change
    create_table :cliente_autonomos do |t|
      t.string :cuit
      t.string :razon_social
      t.string :nombre
      t.integer :codigo_tipo_responsable
      t.string :email
      t.string :tipo_cliente

      t.timestamps
    end
  end
end
