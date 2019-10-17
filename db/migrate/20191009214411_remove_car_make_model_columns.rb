class RemoveCarMakeModelColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column(:drivers, :car_make)
    remove_column(:drivers, :car_model)
  end
end
