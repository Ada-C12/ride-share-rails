class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.datetime :date
      t.integer :rating
      t.float :cost
      t.timestamps
    end

    add_reference :trips, :driver, foreign_key: true
    add_reference :trips, :passenger, foreign_key: true
  end
end
