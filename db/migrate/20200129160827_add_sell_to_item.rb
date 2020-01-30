class AddSellToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :sell, null: true, foreign_key: true
  end
end
