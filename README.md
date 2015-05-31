![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

## Objectives
* Create a Review Model and Migration that implements a move review.
* Review the migration that implements this movie-review relationship.
* Show how a movie's relationship to a review is one to many.
* Draw a the Entity Relationship Diagram (ERD), and DB Tables, to show how foreign keys are used to implement these 1 to many relationships in the DB.
* Use ActiveRecord `has_many` and `belongs_to` to implement this movie/review relationship.
* Use the Rails console to create movie reviews.
* Create seed data to pre-populate a couple of movie reviews.
* Create a nested resource for movie reviews.
* Create a Review Controller that will return a JSON representation of movie reviews.


## Code Along: Setup

**Make sure you fork, clone, create the DB, migrate and seed the DB.**

```
rake db:create
rake db:migrate
rake db:seed
```

**Run the server**

```
rails server
```

Ok, you should now be able to see the JSON for all three movies at `http://localhost:3000` and the JSON for the movie "Mad Max" at `http://localhost:3000/movies/2`


## Code Along: Create a Review Model

Lets use a rails generator to create the Review Model. This will also create a migration for this Review Model.

**Create the Review Model and Migration. Apply the migration**
```
rails g model Review name:string comment:text movie:references
rake db:migrate
```

**Open up the migration generated**

This will show ,for us, a new kind of column. A column that will contain the **foreign key** to a movie.

```ruby
  ...
  t.references :movie, index: true, foreign_key: true
  ...
```

This will create a **foreign key** column in the reviews table. 

The **foreign key** column will contain the id of movie that the review pertains to. 

Another words, the movie "Affliction" has an id of 1. If we create a review for this movie then the row reviews table will have a **foreign key** column, named *movie_id*, with a value of 1.

**Open up the Rails DB console and take a look at the tables we now have**

```
rails db

\dt
\d movies
\d reviews
```

The `\d` will show all the tables.

 `\dt movies` and `\dt reviews` will show the columns for movies and reviews tables. 
 
*Notice that the reviews table now has a movie_id column. This is the foreign key that references a specific movie by it's id.*

**Open up the db/schema.rb**

And see that the 'reviews' table has a entry 'movie_id' that is the **foreign key**.


## Code Along: Create a Movie Review.

**Open the app/models/review.rb**

Notice the **belongs_to** method in the Review Model. This will create a relationship from the review to the movie that the review pertains to.

**Add this to the app/models/movies.rb**

```
has_many :reviews
```

The *has_many* method will create a relationship from the Movie Model to the Review model.

Notice how the langauge matches the relationships. A movie may **have many** reviews. And a review **belongs to** one movie.

This is called a **one to many** relationship. Each movie can have many reviews.

**Enough talk, let's create the review in Rails console.**

```
rails c

m1 = Movie.first
m1.reviews

```

Notice, a movie now has the reviews method! The **has_many** added to the Movie Model above actually gave the Movie Model this reviews method.

If we were to do this by hand, not using **has_many**, we would do **something like** this. *Warning: very, very simplified example!*

```
 class Movie < ActiveRecord::Base
 
   # VERY SIMPLIFIED EXAMPLE ONLY, DON'T DO THIS!!
   def reviews
      # return the Array of reviews for this movie
      reviews 
   end
 end
```
Let's continue.

```
Review.all

m1.reviews.create(name: 'Tom', comment: 'Dark, somber')

r1 = Review.first

m1.reviews
```

First we see that there are no Reviews when we run `Review.all`. 

Then we create a review for the movie 'Affliction' with `m1.reviews.create(name: 'Tom', comment: 'Dark, somber')`. 

Then we get the one and only review at this time in the DB with the `r1 = Review.first`. 

Then we show all the movie, 'Affliction', reviews, `m1.reviews`. This will generate a SQL SELECT to find all the reviews for the movie 'Affliction'.

```sql
SELECT "reviews".* FROM "reviews" WHERE "reviews"."movie_id" = $1  [["movie_id", 1]]
```

**Open up the rails db console and run this SQL**

```
SELECT * FROM reviews WHERE reviews.movie_id = 1;
```

See, this is the SQL created and executed when we do `m1.reviews`

**Let's draw what the movies and reviews tables in the DB look like at this time**

**Let's confirm our drawing by using rails db**

```
rails db

SELECT * FROM reviews;

SELECT * FROM movies;
```

See how the movie_id in the reviews column has the value 1. This is the id of the movie that the review is for.


## Lab: Create a Album with Songs.
Work in Groups.

* An Album will have a title, artist name, released year.

* A Song will have a title, duration and price.

* An Album may have many Songs.

* A Song belongs to an Album.

* Create, in the Rails console, a couple of Albums. Each having one or more Songs. 

* (Optionally) Create Albums and Songs in the seed file.

* What happens if in the rails console you:

```
s1 = Song.first
s1.album
```

Yes, the `belongs_to` in the Song Model adds a `album` method to the Song that returns the album the song belongs to.

* Draw, as a group, the DB tables for Albums and Songs. Each table should have a row for each Album and Song. (Don't forget to show the foreign keys!)

## Code Along: Populate Movie Reviews

**Add to the seed file**

```
Review.delete_all
Movie.delete_all

movie = Movie.create!(name: 'Affliction', rating: 'R', desc: 'Little Dark', length: 123)
movie.reviews.create!(name: 'Tom', comment: 'Dark, somber')
movie.reviews.create!(name: 'Meg', comment: 'Slow, boring')

movie = Movie.create!(name: 'Mad Max', rating: 'R', desc: 'Fun, action', length: 154)
movie.reviews.create!(name: 'Joe', comment: 'Explosions, silly')
movie.reviews.create!(name: 'Christine', comment: 'Brilliant, fun')

movie = Movie.create!(name: 'Rushmore', rating: 'PG-13', desc: 'Quirky humor', length: 105)
movie.reviews.create!(name: 'Tom', comment: 'Crazy, humor')
movie.reviews.create!(name: 'Joanne', comment: 'Waste of time, stupid')

puts "Created three Movies"
```

## Code Along: Create a nested route for Reviews.

When we access a review using a URL we will **ALWAYS** refer to the movie that that review belongs to. 


For example when we want to see all a specific movie's reviews we will use the URL. `http://localhost:3000/movies/1/reviews`

**Add this to the routes file**  

```ruby
  # create routes for movie resource                                            
  resources :movies, except: [:new, :edit] do
    # create nested routes for the movie reviews                                
    resources :reviews, except: [:new, :edit]
  end

```

This will **nest** the routes to reviews inside of the movie routes. *Note, by default Rails also generates routes for the new and edit actions. We don't need these actions in a JSON API.*

**Run rake routes to look at the new routes created**

## Code Along: Create a Reviews Controller.

**Create a reviews controller and index action** 

```
class ReviewsController < ApplicationController
  # GET /movies/:movie_id/reviews                                               
  def index
  	 # movie the review pertains to
    @movie = Movie.find(params[:movie_id])

    # all the reviews for a movie
    @reviews = @movie.reviews

    render json: @reviews
  end
end

```

**Access `http://localhost:3000/movies/2/reviews`**

Now you'll see the JSON Representation of the 'Mad Max' movie reviews.


## Code Along: Create the Review Show Action.

**Add the show action to the reviews controller**

```
 # GET /movies/:movie_id/review/:id                                            
  def show
	 # movie the review pertains to
    @movie = Movie.find(params[:movie_id])

    @review = @movie.reviews.find(params[:id])
    render json: @review
  end
```

*Go to `http://localhost:3000/movies/2/reviews/4` to check the reviews controller show action*


## Code Along: before_action

Each action in the Reviews Controller will need to have an instance variable, @movie, that contains the Movie. 

We could just copy the code to get the movie into each and every action. But, this wouldn't be *DRY*.

```ruby
 @movie = Movie.find(params[:movie_id])
```

Rails give us a way to say. Execute a method *before* an action is executed. Use the `before_action` and give it the name of the method to execute before each action.

```ruby
  # Execute this method before each action is executed                          
  before_action :set_movie
```

This method, `set_movie` should be private so it can't be invoked by an application user.

```ruby
  ...
  private

  # find the movie for the review/s                                             
  def set_movie
    # create an instance variable that can be accessed in                       
    # every action.                                                             
    @movie = Movie.find(params[:movie_id])
  end
  ...
```

Now, your ReviewController should look like:

```ruby
class ReviewsController < ApplicationController
  # Execute this method before each action is executed                          
  before_action :set_movie

  # GET /movies/:movie_id/reviews                                               
  def index
    # all the movies                                                            
    @reviews = @movie.reviews
    render json: @reviews
  end

  # GET /movies/:movie_id/review/:id                                            
  def show
    @review = @movie.reviews.find(params[:id])
    render json: @review
  end

  private

  # find the movie for the review/s                                             
  def set_movie
    # create an instance variable that can be accessed in                       
    # every action.                                                             
    @movie = Movie.find(params[:movie_id])
  end
end

```

This will use the `before_action` method that will find the movie that the reviews belong to. *Look up the before_action method in the Rails documentation.*

You'll see that when we create more actions they will all run the code in the `set_movie` action to set the @movie instance variable.


*Go to `http://localhost:3000/movies/1/reviews` to check the reviews controller index action*


## Code Along: Create the Review Destroy Action.

**Add the destroy action to the reviews controller**
```
  # DELETE /movies/:movie_id/reviews/:id                                        
  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    head :no_content
  end
```

```
curl -X DELETE localhost:3000/movies/3/reviews/6
```

## Code Along: Create the Review Create Action.

**Add the create action to the reviews controller.**

```
  # POST /movies/:movie_id/reviews                                         
  def create
    @review = @movie.reviews.build(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end

  end
  
  ...
  
  def review_params
    params.require(:review).permit([:name, :comment])
  end
```

**Send a HTTP POST to movies/2/reviews with a review name and comment**

```
curl -X POST -d "review[name]=Jackie&review[comment]=Sucks" http://localhost:3000/movies/2/reviews
```

## Lab: Create Album and Song Controllers and nested routes.

Pretty much the same as above but using album has many songs instead of movie has many reviews.

## Reference

* [Rails Association Basics](http://guides.rubyonrails.org/association_basics.html) Read the sections on belongs_to and has_many.

* [Rails Documentation](http://api.rubyonrails.org/)

* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)

* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/?utm_source=rubyweekly&utm_medium=email)

* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)



