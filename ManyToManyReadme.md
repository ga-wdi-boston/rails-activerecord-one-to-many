# Many to Many Relationships

### Objectives
* Create many to many relationship.

* Add a User - Album Many to Many relationship
 `r g model ManagedAlbums user:belongs_to album:belongs_to role`
 
 Take a look at the migration and model generated.
 
* In the User model, user.rb add.  

```
 has_many :managed_albums, class_name: 'ManagedAlbums' 
  has_many :albums, through: :managed_albums
```

I've added the role so that we can in the future authorize action based on the role or admin, creative director and artist. 


* Add Seed data.

```
User.delete_all
...

jill =  User.create!(email: 'jill@example.com', password: 'password')
fred =  User.create!(email: 'fred@example.com', password: 'password')
mort =  User.create!(email: 'mort@example.com', password: 'password')
```


* In the rails console.  

```
jill = User.first
jill.managed_albums.new(album: Album.last, role: 'artist')

```
We've created a managed album for jill. Notice that the user_id is set to jill's id, primary in the user table.

The album_id is set to the primary of the last Album. 

We have __not__ yet persisted this ManagedAlbum instance, it's id is nil. 

* Save jill and the reload jill from the DB.

```
jill.save
jill = User.first
jill.managed_albums
jill.albums
```

Now we see that not only does jill have managed_articles. She also has articles.


__The articles for a user are found via the join table, managed_articles, when using a "through" relationship.__


* Remove Managed albums when removing a user.

Add a dependent: :destroy to the managed_albums in the User model.

```
  has_many :managed_albums, class_name: 'ManagedAlbums', dependent: :destroy
```

* Update seeds 

```
mule = Album.create!(name: 'Mule Variations', genre: 'jazz')
mule.songs.create!(title: 'Chocolate Jesus', artist: 'Tom Waits', duration: 133, price: 1.99)
mule.songs.create!(title: 'Picture in a Frame', artist: 'Tom Waits', duration: 202, price: 3.99)

mort.managed_albums.create!(album: nevermind, role: 'admin')
mort.managed_albums.create!(album: sea_change, role: 'artist')
jill.managed_albums.create!(album: nevermind, role: 'artist')
jill.managed_albums.create!(album: sea_change, role: 'artist')
fred.managed_albums.create!(album: nevermind, role: 'creative director')
tom.managed_albums.create!(album: mule, role: 'artist')
```

### Lab

Create a User method to find all user songs. 


