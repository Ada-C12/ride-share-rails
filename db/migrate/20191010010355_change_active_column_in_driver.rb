class ChangeActiveColumnInDriver < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :active
    add_column :drivers, :available, :boolean, default: true
  end
end
