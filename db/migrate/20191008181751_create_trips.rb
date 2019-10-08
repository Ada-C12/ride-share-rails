class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.date :date
      t.float :cost
      t.integer :rating
      t.integer :passenger_id
      t.integer :driver_id
      
      t.timestamps
    end
  end
end
