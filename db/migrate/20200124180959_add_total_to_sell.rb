class AddTotalToSell < ActiveRecord::Migration[6.0]
  def change
    add_column :sells, :total, :decimal
  end
end
