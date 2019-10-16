class DefaultCostAndRatingColumnsToNil < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :cost, :integer
    remove_column :trips, :rating, :integer
  end
end
