class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.integer :stop_id
      t.integer :stop_code
      t.string :stop_name
      t.decimal :stop_lat
      t.decimal :stop_lon
      t.integer :location_type
      t.integer :wheelchair_boarding
      t.string :transport_type

      t.timestamps
    end
  end
end
