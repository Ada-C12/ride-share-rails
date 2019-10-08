class AddMakeModelAndActiveToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :car_make, :string
    add_column :drivers, :car_model, :string
    add_column :drivers, :active, :boolean, default: true
  end
end
