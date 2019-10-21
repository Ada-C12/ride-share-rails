class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.float :rating
      t.float :price
      t.date :date

      t.timestamps
    end
  end
end
