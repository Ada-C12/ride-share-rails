class AddStatusColumToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column(:drivers, :status, :boolean )
  end
end
