class ChangePriceToCost < ActiveRecord::Migration[6.0]
  def change
    rename_column :trips, :price, :cost
  end
end
