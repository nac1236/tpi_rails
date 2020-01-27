class AddSoldPriceToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :sold_price, :decimal
  end
end
