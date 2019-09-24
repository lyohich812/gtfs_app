class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.timestamp :timestamp
      t.string :position
      t.integer :direction
      t.integer :routeId
      t.integer :vehicleLabel
      t.integer :velocity
      t.integer :vehicleId
      t.integer :orderNumber
      t.string :licensePlate
      t.integer :directionId

      t.timestamps
    end
  end
end
