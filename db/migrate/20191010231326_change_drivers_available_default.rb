class ChangeDriversAvailableDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :drivers, :available, :boolean, :default => true
  end
end
