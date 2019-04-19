class AddOnTripStatustoPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :on_trip, :boolean, :default => false
  end
end
