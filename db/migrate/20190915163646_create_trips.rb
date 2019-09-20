class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :route_id
      t.integer :service_id
      t.integer :trip_id
      t.integer :direction_id
      t.string :shape_id

      t.timestamps
    end
  end
end
