class AddActiveColumnToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :active, :boolean, default: false
  end
end
