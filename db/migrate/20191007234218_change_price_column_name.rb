class ChangePriceColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:trips, :price, :cost)
  end
end
