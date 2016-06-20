#Album class
class Album # Albums have an artist, title and tracks
  attr_reader :artist, :title
  attr_accessor :tracks

  @@collection = []

  def initialize(artist:, title:)
    @artist = artist
    @title = title
    @tracks = []

    @@collection << self
  end

  def self.all
    @@collection
  end

  def self.find_by_title(query)
    @@collection.select { |album| album.title == query }
  end
end

class Song
  attr_reader :title
  attr_accessor :rating

  def initialize(title:)
    @title = title
    @rating
  end
end


Adele = Album.new(title: '21', artist: 'Adele')
Thriller = Album.new(title: 'Thriller', artist: 'Michael Jackson')
T_Swift = Album.new(title: '1989', artist: 'Taylor Swift')
USA = Album.new(title: 'Born in the U.S.A.', artist: 'Bruce Springsteen')
Gaga = Album.new(title: 'The Fame', artist: 'Lady Gaga')
Frozen = Album.new(title: 'Frozen', artist: 'The Frozen Soundtrack')
Def = Album.new(title: 'Hysteria', artist: 'Def Leppard')


#   { title: 'Hello', length: 216, rating: 4 },
#   { title: 'Thriller', length: 238, rating: 5 },
#   { title: 'Bad Blood', length: 205, rating: 4 },
#   { title: 'Born in the U.S.A.', length: 227, rating: 5 },
#   { title: 'Poker Face', length: 256, rating: 3 },
#   { title: 'Let it go', length: 199, rating: 11 },
#   { title: 'Hello', length: 234, rating: 4 },
#   { title: 'Hysteria', length: 301, rating: 5 }


# t_swift = Album.new(artist: 'Taylor Swift', title: '1989')
# t_swift.tracks << Song.new(title: 'Shake It Off')
# t_swift.tracks << Song.new(title: 'Bad Blood')
#
# nevermind = Album.new(artist: 'Nirvana', title: 'Nevermind')
# nevermind.tracks << Song.new(title: 'Smells Like Teen Spirit')

# brians_favorite = Album.find_by_title('1989')
