class ChangeActiveDefaultValueInDrivers < ActiveRecord::Migration[5.2]
  def change
    change_column :drivers, :active, :boolean, :default => false
  end
end
