Album.delete_all
Song.delete_all

sea_change = Album.create(name: "Sea Change", genre: 'rock')
sea_change.songs.new(title: 'Golden Age', artist: "Beck", price: 1.99, duration: 215)
sea_change.songs.new(title: 'Lost Cause', artist: "Beck", price: 4.99, duration: 182)
sea_change.songs.new(title: 'Lonesome Tears', artist: "Beck", price: 2.99, duration: 156)
sea_change.save!

nevermind = Album.create(name: 'Nevermind', genre: 'rock')
nevermind.songs.new(title: 'Lithium', artist: 'Nirvana', price: 3.99, duration: 198)
nevermind.songs.new(title: 'Smells Like Teen Spirit', artist: 'Nirvana', price: 3.99, duration: 198)
nevermind.save!