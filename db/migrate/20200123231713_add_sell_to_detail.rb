class AddSellToDetail < ActiveRecord::Migration[6.0]
  def change
    add_reference :details, :sell, null: false, foreign_key: true
  end
end
