Album.delete_all
Song.delete_all

sea_change = Album.create(name: "Sea Change", genre: 'rock')
sea_change.songs.create!(title: 'Golden Age', artist: "Beck", price: 1.99, duration: 215)
sea_change.songs.create!(title: 'Lost Cause', artist: "Beck", price: 4.99, duration: 182)
sea_change.songs.create!(title: 'Lonesome Tears', artist: "Beck", price: 2.99, duration: 156)

# Create the album
nevermind = Album.create(name: 'Nevermind', genre: 'rock')
nevermind.songs.create!(title: 'Lithium', artist: 'Nirvana', duration: 193, price: 1.99)
nevermind.songs.create!(title: 'Come as you are', artist: 'Nirvana', duration: 177, price: 1.49)


