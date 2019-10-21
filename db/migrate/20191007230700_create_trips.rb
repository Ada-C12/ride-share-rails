class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.date :date
      t.string :rating
      t.string :cost
      
      t.timestamps
    end
  end
end
