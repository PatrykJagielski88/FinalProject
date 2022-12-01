class AddColumnsInOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :list_of_products, :string
    add_column :orders, :grand_total, :float
    add_column :orders, :taxes, :float
  end
end
