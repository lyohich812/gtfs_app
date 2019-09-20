class AddIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :trips, :route_id
    add_index :trips, :shape_id
    add_index :stop_times, :trip_id
    add_index :stop_times, :stop_id
    
  end
end
