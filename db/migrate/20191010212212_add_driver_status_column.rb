class AddDriverStatusColumn < ActiveRecord::Migration[5.2]
  def change
    add_column(:drivers, :status, :string, :default => "available")
  end
end
