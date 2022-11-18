class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.float :price
      t.string :description

      t.timestamps
    end
  end
end
