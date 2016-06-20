# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.transaction do
  CSV.foreach 'data/cities.csv', headers: true do |city|
    City.create(city.to_hash)
  end
end

People.transaction do
  CSV.foreach 'data/people.csv', headers: true do |person|
    Person.create(person.to_hash)
  end
end
