class SetAccountStatusDefaultInPassengers < ActiveRecord::Migration[5.2]
  def change
    remove_column :passengers, :account_status
    add_column :passengers, :account_status, :boolean, default: true
  end
end
