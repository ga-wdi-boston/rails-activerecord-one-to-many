city = City.new population: 13_000_000,
                name: 'New York',
                country: 'US',
                region: 'NY',
                longitude: -74.0059,
                latitude: 40.7127
city.save!
p city
