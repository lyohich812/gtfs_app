class CreateRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.integer :route_id
      t.integer :agency_id
      t.string :route_short_name
      t.string :route_long_name
      t.integer :route_type
      t.string :transport_type
      t.integer :circular
      t.integer :urban
      t.integer :night

      t.timestamps
    end
  end
end
