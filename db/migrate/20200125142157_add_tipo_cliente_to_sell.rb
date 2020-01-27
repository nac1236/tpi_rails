class AddTipoClienteToSell < ActiveRecord::Migration[6.0]
  def change
    add_column :sells, :tipo_cliente, :string
  end
end
