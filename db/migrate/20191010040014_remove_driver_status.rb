class RemoveDriverStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column(:drivers, :status)
    add_column(:drivers, :status, :string, :default => "available" )
  end
end
