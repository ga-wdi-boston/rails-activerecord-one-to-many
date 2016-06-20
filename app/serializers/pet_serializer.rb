class PetSerializer < ActiveModel::Serializer
  attributes :id, :born_on, :kind, :name
end
