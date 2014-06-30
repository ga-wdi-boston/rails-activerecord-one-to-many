class Album < ActiveRecord::Base

  # dependent: :destroy - Will destroy, or remove, all child objects
  # in memory and in the the DB.
  has_many :songs, dependent: :destroy

  # has_many :all_album_songs, class_name: :songs

  # # Get all this albums songs.
  # def songs
  #   @songs = Song.where(album_id: self.id)
  #   select * from songs where album_id = 3
  # end

  # # Add a song to this album
  # def songs<<(song)
  #   song.album_id = self.id
  #   @songs << song
  #   song.save
  # end

end
