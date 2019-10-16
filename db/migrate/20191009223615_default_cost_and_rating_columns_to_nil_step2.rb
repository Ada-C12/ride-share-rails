class DefaultCostAndRatingColumnsToNilStep2 < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :cost, :integer, default: nil
    add_column :trips, :rating, :integer, default: nil
  end
end
