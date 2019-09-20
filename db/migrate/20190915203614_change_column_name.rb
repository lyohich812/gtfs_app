class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    add_index :routes, :route_id
    add_index :shapes, :shape_id
    add_index :stops, :stop_id
    add_index :trips, :trip_id

    

  end
end
