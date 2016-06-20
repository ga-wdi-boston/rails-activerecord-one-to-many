class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :songs
end
