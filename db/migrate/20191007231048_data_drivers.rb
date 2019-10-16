class DataDrivers < ActiveRecord::Migration[5.2]
  def change
    
    add_column :drivers, :name, :string
    add_column :drivers, :vin, :string
  end
end
