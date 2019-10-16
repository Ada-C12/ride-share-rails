class RemoveDriverIdFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :driver_id, :integer
  end
end
