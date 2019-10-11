class AddTotalSpentToPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :total_spent, :integer
  end
end
