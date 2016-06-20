class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :rating, :album_id
end
