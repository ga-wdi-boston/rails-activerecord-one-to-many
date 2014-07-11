class FakeSongAPI
  # Simulate an API that has a 
  ALBUMS = [
            { uid: 33, title: 'lunar escape ep', artist: 'psychemagik', genre: 'dance' },
            { uid: 34, title: 'sea change', artist: 'beck', genre: 'rock' },
            { uid: 35, title: 'seasons change', artist: 'mazzy star', genre: 'rock' }
           ]

  SONGS = [
           {uid: 1, title: 'bass purr', duration: 184, album_uid: 33 },
           {uid: 2, title: 'end of the day', duration: 155, album_uid: 34 },
           {uid: 3, title: 'little one', duration: 178, album_uid: 34 },
           {uid: 4, title: 'golden age', duration: 144, album_uid: 34 },
           {uid: 5, title: 'sunday sun', duration: 203, album_uid: 34 },
           {uid: 6, title: 'lost cause', duration: 199, album_uid: 34 },
           {uid: 7, title: 'paper tiger', duration: 178, album_uid: 34 },
           {uid: 8, title: 'end of day', duration: 156, album_uid: 34 },     

           {uid: 9, title: 'fade into you', duration: 188, album_uid: 35 }
          ]

  def self.find_album_by_id(id)
    ALBUMS.find{ |a| a[:uid] == id }
  end
  
  def self.find_songs_by_title(title)
    SONGS.select{ |song| song[:title] == title }
  end

end
