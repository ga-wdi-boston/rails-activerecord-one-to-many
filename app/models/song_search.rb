class SongSearch
  include ActiveModel::Model


  attr_accessor :title
  attr_reader :api_results

  def self.search(query)
    title = query[:title]
    songs = []

    api_songs = FakeSongAPI.find_songs_by_title(title)

    api_songs.each do |as|
      # ask the API for the name of this song's album
      api_album = FakeSongAPI.find_album_by_id(as[:album_uid])

      # Each song MUST be part of an album
      album = Album.find_or_create_by!(name: api_album[:title]) do |album|
        album.genre = api_album[:genre]
      end

      song = Song.find_or_create_by!(title: as[:title]) do |song|
        song.duration = as[:duration]
        song.album = album
        song.artist = api_album[:artist]
      end
      songs << song
    end
    songs
  end
end
