class ChangeActiveColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:drivers, :acitve, :active)
  end
end
