# cities = City.where 'latitude < :max AND latitude > :min',
#                     max: 10, min: -10
# cities = City.where country: %w(UK JP)
cities = City.where latitude: (-10..10)
cities.each { |city| puts city.name }
