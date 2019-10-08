class AddStatusColumntoDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :active, :boolean
  end
end
