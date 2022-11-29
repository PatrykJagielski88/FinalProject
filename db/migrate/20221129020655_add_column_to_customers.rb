class AddColumnToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :user_id, :integer
  end
end
