class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :vin
      t.boolean :available

      t.timestamps
    end
  end
end
