class RenameColumnInProdDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_details, :total_price, :price_per_one
  end
end
