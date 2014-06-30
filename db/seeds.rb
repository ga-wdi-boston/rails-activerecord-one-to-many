Album.delete_all
Song.delete_all

sea_change = Album.create(name: "Sea Change")
sea_change.songs.create!(title: 'Golden Age', artist: "Beck", price: 1.99, duration: 215)
sea_change.songs.create!(title: 'Lost Cause', artist: "Beck", price: 4.99, duration: 182)
sea_change.songs.create!(title: 'Lonesome Tears', artist: "Beck", price: 2.99, duration: 156)

nevermind = Album.create(name: 'Nevermind')
