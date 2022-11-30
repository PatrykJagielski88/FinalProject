class RenameShowToAboutInAbouts < ActiveRecord::Migration[7.0]
  def change
    rename_column :abouts, :show, :about
  end
end
