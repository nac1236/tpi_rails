class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :description
      t.text :detail
      t.decimal :cost_per_unit

      t.timestamps
    end
  end
end
