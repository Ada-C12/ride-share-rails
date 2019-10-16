class AddNameToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :name, :string
  end
end
