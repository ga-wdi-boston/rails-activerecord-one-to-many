class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :rating
end
