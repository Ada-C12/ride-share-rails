class ChangeColumnNameToAvailable < ActiveRecord::Migration[5.2]
  def change
    rename_column(:drivers, :status, :available)
    change_column(:drivers, :available, :boolean, default: true)

  end
end
