# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@routesFileName = 'C:\Sites\rails_project\gtfs_app\app\assets\feed\routes.txt'
@shapesFileName = 'C:\Sites\rails_project\gtfs_app\app\assets\feed\shapes.txt'
@stopTimesFileName = 'C:\Sites\rails_project\gtfs_app\app\assets\feed\stop_times.txt'
@tripsFileName = 'C:\Sites\rails_project\gtfs_app\app\assets\feed\trips.txt'
@stopsFileName = 'C:\Sites\rails_project\gtfs_app\app\assets\feed\stops.txt'

# ImportService.import(@routesFileName, "Route")

# ImportService.import(@tripsFileName, "Trip")

# ImportService.import(@shapesFileName, "Shape")

# ImportService.import(@stopTimesFileName, "StopTime")

# ImportService.import(@stopsFileName, "Stop")
