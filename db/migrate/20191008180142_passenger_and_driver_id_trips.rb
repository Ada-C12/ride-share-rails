class PassengerAndDriverIdTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :passenger_id, :integer
    add_column :trips, :driver_id, :integer
  end
end
