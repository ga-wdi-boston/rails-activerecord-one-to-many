class PersonSerializer < ActiveModel::Serializer
  attributes :id, :given_name, :surname, :gender, :height, :weight, :born_on, :home_town_id, :pets
end
