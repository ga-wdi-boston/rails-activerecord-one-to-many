## Rails Has Many and Belongs to relationships

### Objectives    
* Create models with _"have many"_" and a _""belongs to"_ relationships
* Show how _"parent"_ and _"child"_ relationships are created and managed.


Will we start by creating a relationship between Albums and songs. 
An album will "have many" songs. And a song will "belong to", or be a child of an Album.

In the Lab sections students will create a relationship between authors and books. The Author will be the "parent" and the Book will be a "child" of the Author. These terms will become more clear as we work through this lesson.


* Draw a relationship between a Album and a Song.  DB tables and Rails models.

### Belongs to.
We have created an Album resource already in this app.

An Album will have a name. 
A Song will have a title, artist, duration and price.

We could just add new columns to the Album table.  

song_1_title, song_1_artist, ... , song_2_title, song_2_artist, ...

Why would we _NOT_ do this?

##### Create a Song with an album foreign key. 

```
rails g model Song title:string artist:string duration:integer price:decimal album:belongs_to 
```






