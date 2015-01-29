class SongSearch
  include ActiveModel::Model


  attr_accessor :title
  attr_reader :api_results

  def self.search(query)
    title = query[:title]
    songs = []

    song = Song.find_or_create_by!(title: as[:title]) do |song|
      # TODO: get all that match query and add
      api_song = FakeSongAPI.find_songs_by_title(title).first

      # 
      api_album = FakeSongAPI.find_album_by_id(api_song[:album_uid])

      # Each song MUST be part of an album
      album = Album.find_or_initialize_by!(uid: api_song[:album_id]) do |album|
        album.name = api_album[:title]
        album.genre = api_album[:genre]
        artist = api_album[:artist]
      end
      album.songs.new(title: api_song[:title], duration: api_song[:duration], artist: api_album[:artist] )        
    end

    #     song.album = album
    #     song.artist = api_album[:artist]
    #   end
    #   songs << song
    # end
    # api_songs = FakeSongAPI.find_songs_by_title(title)

    # api_songs.each do |as|
    #   # ask the API for the name of this song's album
    #   api_album = FakeSongAPI.find_album_by_id(as[:album_uid])

    #   # Each song MUST be part of an album
    #   album = Album.find_or_create_by!(name: api_album[:title]) do |album|
    #     album.genre = api_album[:genre]
    #   end

    #   song = Song.find_or_create_by!(title: as[:title]) do |song|
    #     song.duration = as[:duration]
    #     song.album = album
    #     song.artist = api_album[:artist]
    #   end
    #   songs << song
    # end
    # songs
  end
end
