class AddStatusColumnToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column(:drivers, :status, :string)
  end
end
