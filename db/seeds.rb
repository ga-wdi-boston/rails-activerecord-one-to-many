Album.delete_all
Song.delete_all

# sea_change = Album.create(name: "sea change", genre: 'rock')
# sea_change.songs.create!(title: 'golden age', artist: "beck", price: 1.99, duration: 215)
# sea_change.songs.create!(title: 'lost Cause', artist: "beck", price: 4.99, duration: 182)
# sea_change.songs.create!(title: 'lonesome Tears', artist: "beck", price: 2.99, duration: 156)

# # Create the album
# nevermind = Album.create(name: 'nevermind', genre: 'rock')
# nevermind.songs.create!(title: 'lithium', artist: 'nirvana', duration: 193, price: 1.99)
# nevermind.songs.create!(title: 'come as you are', artist: 'nirvana', duration: 177, price: 1.49)


['golden age', 'lost cause', 'lonesome tears', 'lithium', 'come as you are'].each do |song_name|
  puts "Creating song #{song_name}"
  SongSearch.search(title: song_name)
end
