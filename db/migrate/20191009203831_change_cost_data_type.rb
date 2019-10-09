class ChangeCostDataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :cost
    add_column :trips, :cost, :integer
  end
end
