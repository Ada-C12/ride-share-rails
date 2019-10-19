class ChangeDriversColumnDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:drivers, :active, false)
  end
end
