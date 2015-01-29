## FROM PREVIOUS README
---
## Lab

In the assoc_books git branch, create a has_many parent relationship from the Author to the Book model. Don't forget the dependent: :destroy.


## Lab
Add validations.  

Add a genre to the Album. Also albums must have a name and the genre must be either rock, rap, country, jazz or ska. 

Songs must have a title, artist, duration (greater than 60 seconds). No price is required.

## Lab
In the assoc_books git branch. Authors must have a name. Book must have a title.


## Nested Resources

* Create a couple more songs to another album and seed DB.

```
nevermind = Album.create(name: 'Nevermind', genre: 'rock')
nevermind.songs.new(title: 'Lithium', artist: 'Nirvana', price: 3.99, duration: 198)
nevermind.songs.new(title: 'Smells Like Teen Spirit', artist: 'Nirvana', price: 3.99, duration: 198)

```
* Create a Songs controller with a route, index and show actions with views.  

The problem here is that we are showing all the songs. We want to show __ONLY__ the songs for each album.

* Let's try add a URL parameter to find only the songs for a specific album.

``` 
def index
  @album = Album.find(params[:album_id])  
  @songs = @album.songs
end	
```

Now if you go to localhost:3000/songs?album_id=1 you will see ONLY the songs that belong to, are scoped to, the first album.

We would like to always show songs that belong to a particular album. And we want to use a better way to identify the _context_ or album in the URL. 

```
localhost:3000/albums/1/songs
```

We can do this by adding a __nested route__.

In the config/routes.rb file.  

```
resources :albums, only: [:index, :show] do
    # All songs require a nested route.
    resources :songs, only: [:index, :show]
end
```

And look at our routes, http://localhost:3000/rails/info/routes. Notice all routes for songs are scoped to an album.


We will have to change show path helpers in our views.

Add a link to the album show page to show all the songs.

In app/views/albums/show.html.erb  

```
 <p>
   <%= link_to('Songs', album_songs_path(@album) )%>   
 </p>
```

## Before Filter

Let's add a before_action method the songs controller. This will use one private method in the controller to get the album for each song. It should be private because it will only be called by another method inside the controller (in this case, the before_action), but never called from outside the controller the way that index, show, etc. get called.

In the app/controllers/songs_controller.rb

```
before_action :set_album, only: [:index, :show]

...

private 
  def set_album
    @album = Album.find(params[:album_id])  
  end
  
```

Read more about [before filters](http://guides.rubyonrails.org/action_controller_overview.html#filters).


## Lab

In the assoc_books git branch, create a Book route, controller, index and show actions and views.

Make Book a nested route of Author and use a before action in the books controller.


## Nested Route Forms

#### Create a song in an album.

#### Update a song in an album.

#### Delete a song from an album.
---
 <!-- end previous day -->

# Many to Many Relationships

### Objectives
* Create a many to many relationship.
* Use to Rails has_many through to find relationships using a join table.
* Create new many to many relationships via a "Join" model.


We are going to model and app that could be used at a Record Company. 

This company has many albums and we have some employees that are responsible for these albums. _Oh, we count artists that have created albums as employees as well_.

Each User may be related to many Albums. And an Album may be associated or related to one or more Users.


##### Authorization (not implementing yet).
The users are all employees and they have different roles. For now, each employee will be either an admin, creative director or artist. 

In the future we will be allowing users with specific roles to have certain permissions on an album. These permissions will be granted based on their role related to an Album.

For example, we only allow users that are admin to delete an album. A creative director can only change an album's genre. And an artist can change the album name. 

### Demo


* Add a User - Album Many to Many relationship
 `r g model ManagedAlbums user:belongs_to album:belongs_to role`
 
 Take a look at the migration and model generated.
 
 I've added the role so that we can in the future authorize actions based on the role or admin, creative director and artist. 


 
* In the User model, user.rb add.  

```
 has_many :managed_albums, class_name: 'ManagedAlbums' 
  has_many :albums, through: :managed_albums
```


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
We've created a managed album for jill. Notice that the user_id is set to jill's id, primary key in the user table.

The album_id is set to the primary key of the last Album. 

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


