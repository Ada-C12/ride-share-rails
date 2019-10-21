class AddColumnsToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :active, :string
    add_column :drivers, :car_model, :string
    add_column :drivers, :car_make, :string
  end
end
