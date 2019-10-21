class AddActiveColumn < ActiveRecord::Migration[5.2]
  def change
    add_column(:drivers, :acitve, :boolean, :default => false)
  end
end
