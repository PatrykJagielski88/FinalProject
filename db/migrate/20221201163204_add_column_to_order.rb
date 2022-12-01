class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :stripe_paid_confirmation, :string
  end
end
