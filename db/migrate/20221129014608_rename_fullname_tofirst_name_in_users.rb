class RenameFullnameTofirstNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :full_name, :first_name
  end
end
