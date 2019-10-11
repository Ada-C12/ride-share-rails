class RemoveMakeFromDrivers < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :car_make
  end
end
