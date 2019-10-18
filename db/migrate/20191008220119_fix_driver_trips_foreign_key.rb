class FixDriverTripsForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trips, :driver
    add_reference :trips, :driver, on_delete: :nullify
  end
end
