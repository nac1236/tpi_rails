class AddProductToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :product, null: false, foreign_key: true
  end
end
