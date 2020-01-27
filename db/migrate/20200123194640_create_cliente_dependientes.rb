class CreateClienteDependientes < ActiveRecord::Migration[6.0]
  def change
    create_table :cliente_dependientes do |t|
      t.string :cuil
      t.string :nombre
      t.integer :codigo_tipo_responsable
      t.string :email

      t.timestamps
    end
  end
end
