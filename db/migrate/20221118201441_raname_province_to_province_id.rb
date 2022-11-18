class RanameProvinceToProvinceId < ActiveRecord::Migration[7.0]
  def change
    rename_column :customers, :province, :province_id
  end
end
