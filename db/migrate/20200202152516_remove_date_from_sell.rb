class RemoveDateFromSell < ActiveRecord::Migration[6.0]
  def change

    remove_column :sells, :date, :datetime
  end
end
