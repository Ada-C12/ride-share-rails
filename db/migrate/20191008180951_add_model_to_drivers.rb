class AddModelToDrivers < ActiveRecord::Migration[5.2]
  def change
    
    add_column :drivers, :car_model, :string
  end
end
