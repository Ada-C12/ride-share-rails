class DeletecarmakemodelFromDriver < ActiveRecord::Migration[5.2]
  def change
    remove_column(:drivers, :car_make, :string)
    remove_column(:drivers, :car_model, :string)
  end
end
