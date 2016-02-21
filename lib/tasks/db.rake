require 'csv'

namespace :db do
  namespace :populate do
    desc 'Fill the database with example data'
    task all: [:people, :pets, :cities]

    desc 'Fill the people table with example data'
    task people: :environment do
      Person.transaction do
        CSV.foreach(Rails.root + 'data/people.csv',
                    headers: true) do |person_row|
          person = person_row.to_hash
          next if Person.exists? person
          Person.create!(person)
        end
      end
    end

    desc 'Fill the cities table with example data'
    task cities: :environment do
      City.transaction do
        CSV.foreach(Rails.root + 'data/cities.csv',
                    headers: true) do |city_row|
          city = city_row.to_hash
          next if City.exists? city
          City.create!(city)
        end
      end
    end

    desc 'Fill the pets table with example data'
    task pets: :environment do
      Pet.transaction do
        CSV.foreach(Rails.root + 'data/pets.csv',
                    headers: true) do |pet_row|
          pet = pet_row.to_hash
          next if Pet.exists? pet
          Pet.create!(pet)
        end
      end
    end
  end
end
