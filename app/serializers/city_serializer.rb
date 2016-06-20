class CitySerializer < ActiveModel::Serializer
  attributes :id, :name, :country, :region, :population, :longitude, :latitude, :people
end
