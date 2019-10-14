class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :vin
    end

    create_table :passengers do |t|
      t.string :name
      t.string :phone_num
    end
    
    create_table :trips do |t|
      t.belongs_to :driver
      t.belongs_to :passenger
      t.integer :driver_id
      t.integer :passenger_id
      t.datetime :date
      t.integer :rating
      t.integer :cost
    end
  end
end
