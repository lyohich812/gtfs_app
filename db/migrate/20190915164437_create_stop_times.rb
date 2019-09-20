class CreateStopTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_times do |t|
      t.integer :trip_id
      t.string :arrival_time
      t.string :departure_time
      t.integer :stop_id
      t.integer :stop_sequence
      t.string :shape_id
      t.float :shape_dist_travelled

      t.timestamps
    end
  end
end
