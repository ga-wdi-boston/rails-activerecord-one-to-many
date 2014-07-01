ManagedAlbums.delete_all
User.delete_all
Album.delete_all
Song.delete_all

jill =  User.create!(email: 'jill@example.com', password: 'password')
fred =  User.create!(email: 'fred@example.com', password: 'password')
mort =  User.create!(email: 'mort@example.com', password: 'password')
tom =  User.create!(email: 'tom@example.com', password: 'password')

sea_change = Album.create(name: "Sea Change", genre: 'rock')
sea_change.songs.create!(title: 'Golden Age', artist: "Beck", price: 1.99, duration: 215)
sea_change.songs.create!(title: 'Lost Cause', artist: "Beck", price: 4.99, duration: 182)
sea_change.songs.create!(title: 'Lonesome Tears', artist: "Beck", price: 2.99, duration: 156)


# Create the album
nevermind = Album.create!(name: 'Nevermind', genre: 'rock')
nevermind.songs.create!(title: 'Lithium', artist: 'Nirvana', duration: 193, price: 1.99)
nevermind.songs.create!(title: 'Come as you are', artist: 'Nirvana', duration: 177, price: 1.49)

mule = Album.create!(name: 'Mule Variations', genre: 'jazz')
mule.songs.create!(title: 'Chocolate Jesus', artist: 'Tom Waits', duration: 133, price: 1.99)
mule.songs.create!(title: 'Picture in a Frame', artist: 'Tom Waits', duration: 202, price: 3.99)

mort.managed_albums.create!(album: nevermind, role: 'admin')
mort.managed_albums.create!(album: sea_change, role: 'artist')
jill.managed_albums.create!(album: nevermind, role: 'artist')
jill.managed_albums.create!(album: sea_change, role: 'artist')
fred.managed_albums.create!(album: nevermind, role: 'creative director')
tom.managed_albums.create!(album: mule, role: 'artist')
