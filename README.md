## Rails Has Many and Belongs to relationships

### Objectives    
* Create models with _"have many"_" and a _""belongs to"_ relationships
* Show how _"parent"_ and _"child"_ relationships are created and managed.
* Associate songs with an album.
* Associate books with an author.


Will we start by creating a relationship between Albums and songs. 
An album will "have many" songs. And a song will "belong to", or be a child of an Album. At this time, each song can only be associated with one album. _This may change in the future_.

In the Lab sections students will create a relationship between authors and books. The Author will be the "parent" and the Book will be a "child" of the Author. These terms will become more clear as we work through this lesson.


* Draw a relationship between a Album and a Song.  DB tables and Rails models.

#### Setup 
We have created an Album resource already in this app. Each Album has one attribute, name. 

An Album will have a name. 

Run bundle, create the app DB, migrate and seed. Then run the server and go to the root to see that we have a couple of albums.


## Belongs To Relationship.

Now we will create a Song that is associated with one Album.

A Song will have a title, artist, duration and price. And it will have a column that will associate it with an Album. Album is the parent resource. 

This column will be named __album_id__ and it will serve as a _foreign key_ to the album that this song belongs to.

The Rails convention for foreign key naming convention is __"resource""_id__, where "resource" is the parent resource/model.  

##### Question:
Could we add new columns to the Album table for each song?

song_1_title, song_1_artist, ... , song_2_title, song_2_artist, ...

##### Create a Song with an album foreign key. 

```
rails g model Song title:string artist:string duration:integer price:decimal album:belongs_to 
```

* Open up the migration generated. Notice the belongs_to :album. 
* Take a look at the songs table in the DB.  
	```
	psql -d wdi_4_rails_has_many_albums_development
	```
* Look at the Seed model in the rails console. It has a foreign key __album_id__.  


We would like methods, getter/setter, on the Song model to return the Album that the song belongs to. Rather than write it ourselve we can use the Rails __belongs_to__. 

Look at the Rails guide for [belongs_to](http://guides.rubyonrails.org/association_basics.html#the-belongs-to-association). And the Rails docs for [belongs_to](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to)


* Add belongs_to to the Song model.
* reload! in the rails console to pick up code changes.
* Create a song with an album.  

	```
	 s = Song.create(title: 'Golden Age', artist: "Beck", price: 1.99, duration: 215)
	 s.album
	 s.album = Album.last
	 s.save
		
	```
	Notice that the belongs_to provided a getter method, album=(), to set the parent. Then you can see that the calling save on the song ran a SQL Update to update the song's album_id foreign key.
	
* Let's get this song from the DB again and call the album 'getter' provided by the belongs_to.  

	```
	s = Song.find_by_title('Golden Age')
	s.album
	```
		
	Notice how using the Song#album method invoke the SQL Select to retrieve the album associated with this song.
	

##### Summary
The Rails belongs_to will:  
* Create a setter method, Song#album=(album).  
* Create a getter method, Song#album.  
* Generate the correct SQL Update or Insert when associating, setting, the parent with the child.
* Generate the correct SQL Select when the Song#album is called.  


## Lab
In a assoc_books git branch. Create Book model and make it belong to an Author.
Book should have a title, price and published_date attributes. Author should have a name. 


## Has Many Relationship.

We would like to be find all the songs in an album. For example, we would like to.  

```
  sea_change = Album.last
  sea_change.songs
```

Once again, we could write our own methods on the class, Album, to get all the songs, Album#songs. Or we could create a method on Album to add a song, Album#songs<<(song). 

But, we can use [has_many](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many) that's provided by Rails. Add.  

```
class Album < ActiveRecord::Base
  has_many :songs
end
```

The [has_many](http://guides.rubyonrails.org/association_basics.html#the-has-many-association) adds methods to a class/model that will provide the above methods. These methods will generate the correct SQL to retrieve all songs that are associated with this album. Or to generate the SQL to associate, or make a child song.


* Show all the songs associated with an album.

```
reload!
sea_change = Album.last
see_change.songs

```

This will generate the SQL to find all the songs, children, in an album, parent.

```
SELECT "songs".* FROM "songs"  WHERE "songs"."album_id" = $1  [["album_id", 2]]
```
* Create a new song for the album.

```
sea_change.songs.new(title: 'Lost Cause', artist: 'Beck', price
: 4.99, duration: 182)
=> #<Song id: nil, title: "Lost Cause", artist: "Beck", duration: 182, price: #\ <BigDecimal:7f8141d05060,'0.499E1',18(45)>, album_id: 2, created_at: nil, updat\
ed_at: nil>
```

Notice how we have created a new song that has a foreign key, album_id, set to this album. _Yay, wee, I am so excited_  

But, this song has __not__ been saved to the DB. It has a nil id, _primary key_.

Now let's save the album.  

```
sea_change.save
   (0.1ms)  BEGIN
  SQL (0.2ms)  INSERT INTO "songs" ("album_id", "artist", "created_at", "durati\
on", "price", "title", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURN\
ING "id"  [["album_id", 2], ["artist", "Beck"], ["created_at", "2014-06-30 00:3\
3:11.201751"], ["duration", 182], ["price", "4.99"], ["title", "Lost Cause"], [\
"updated_at", "2014-06-30 00:33:11.201751"]]
   (7.0ms)  COMMIT
=> true

```

Notice how saving the album saved all children, in this case the "Lost Cause" song.  And the save returned true.

Check it by finding: 
* Getting the album from the DB.  
* Showing all the songs.  __Notice the SQL__
* Finding the song 'Lost Cause'.  
* Call the album method of this song. 

## Removing Parent objects.

We'll see that removing a parent object without deleting it's children can corrupt the data. We want to maintain the _Data Integrity_.

For example, in the rails console.  

```
sea_change.destroy
Album.count
lost = Song.find_by_title('Lost Cause')
lost.album
```

Here we have remove the album from the DB but there are still _orphaned_ children songs in the DB. We have corrupted the data by leaving a foreign key reference in two songs to a _non-existent_ album. _Not good_.

Lets fix this by restoring the DB to a good state by seeding the DB.  

```
Album.delete_all
Song.delete_all

sea_change = Album.create(name: "Sea Change")
sea_change.songs.create!(title: 'Golden Age', artist: "Beck", price: 1.99, dura\
tion: 215)
sea_change.songs.create!(title: 'Lost Cause', artist: "Beck", price: 4.99, dura\
tion: 182)
sea_change.songs.create!(title: 'Lonesome Tears', artist: "Beck", price: 2.99, \
duration: 156)

nevermind = Album.create(name: 'Nevermind')
```

Add the _dependent_ option to has_many.   

```
class Album < ActiveRecord::Base
  has_many :songs, dependent: :destroy
end
```

* In the console.  
  
```
Song.count
sea_change = Album.first
sea_change.destory
sea_change.count

```

Initially, we'll see 3 songs. Then when we destroy the "Sea Change" album we'll see the SQL DELETE run and all of the albums songs will be gone.

Make sure you __DO NOT__ add the dependent: :destroy to the song's belongs_to. 

Why?

Awww, lets screw it up for fun. Go ahead add the dependent: destroy to the belongs_to and remove a song.

## Lab

In a assoc_books git branch. Create a has_many, parent, relationship from the Author to the Book model. Don't forget the dependent: :destroy.


## Lab
Add validations.  

Add a genre to the Album. Also albums must have a name and the genre must be either rock, rap, country, jazz or ska. 

Songs must have a title, artist, duration (greater than 60 seconds). No price is required.

## Lab
In a assoc_books git branch. Authors must have a name. Book must have a title.


## Nested Resources

* Create a couple more songs to another album and seed DB.

```
nevermind = Album.create(name: 'Nevermind', genre: 'rock')
nevermind.songs.new(title: 'Lithium', artist: 'Nirvana', price: 3.99, duration: 198)
nevermind.songs.new(title: 'Smells Like Teen Spirit', artist: 'Nirvana', price: 3.99, duration: 198)

```
* Create a Songs controller with a route, index and show actions with views.  

The problem here is that we are showing all the songs. We want to show __ONLY__ the songs for each album.

* Lets try add a URL parameter to get find only the songs for a specific album.

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

Lets add a before_action method the songs controller. This will use one private controller method to get the album for each song. 

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

In a assoc_books git branch. Create a Book route, controller, index and show actions and views.

Make Book a nested route of Author and use a before action in the books controller.


## Nested Route Forms

#### Create a song in an album.

#### Update a song in an album.

#### Delete a song from an album.

  



















