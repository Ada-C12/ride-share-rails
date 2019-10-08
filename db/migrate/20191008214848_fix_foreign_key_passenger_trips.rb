class FixForeignKeyPassengerTrips < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trips, :passenger
    
    
    add_reference :trips, :passenger, on_delete: :nullify
  end
end
