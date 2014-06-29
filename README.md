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


### Belongs To Relationship.

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














