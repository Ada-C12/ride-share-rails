class AddMakeToDrivers < ActiveRecord::Migration[5.2]
  def change
    
    add_column :drivers, :car_make, :string
  end
end
