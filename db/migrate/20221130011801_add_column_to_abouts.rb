class AddColumnToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :edit, :string
  end
end
