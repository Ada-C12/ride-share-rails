class AddTotalEarnedToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :total_earned, :integer
  end
end
