![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

## Objectives
* Create a CRUD Rails backend app that will act as an API, providing JSON representations of Movies.
* Create a  front-end app, using Ajax, that will use this API to create, read, update and destory movies.
* Draw Diagrams that show the flow of a HTTP Requests and Responses and the how the Model, View and Controller interact.

## Create a new Rails application.


**Install Rails, only if it's not installed.**

*Note: this can be done from within any directory*

```
gem list |grep rails
gem install rails
```
**Create a Rails application named `movies_crud_app`.**

```
rails new movies_crud_app -T --database=postgresql
```

**Review Rail's directory structure.**

Change into this `movies_crud_app` directory and take a look at how Rails gives you a very clear location to place all the code you'll be writing.


```
cd movies_app
subl .

```

**Create a database for this rails app. *Rails always need a DB*.**

And Restart rails.

```
rake db:create
rails server
```

**Access the default Rails URL.**

In your browser, go to port 3000.

Ya, you should see the Welcome Aboard page. Rails is running!!!

## Create a Movie Model

Use a rails generator to create a Movie model.

```
rails generate model Movie name:string rating:string desc:text length:integer
```


Notice what files are generated. What are they and what are they used for?

**Migrate DB**

Open up the the file db/schema.rb before and after the migrations are run below.

```
rake db:migrate
```

This will run the migrations to create a *movies* table that has a name, rating, desc and length columns. 

*Check the DB to confirm the existence of the movies table and the above columns*

```
rails dbconsole
```

This will bring up **psql**. *Command line utility to view the DB.*

Lets look at all the tables in the DB. And describe the movies table. 

```
\dt
\d movies
```

**Create seed data**

Add the below to db/seeds.rb

```
Movie.delete_all

Movie.create!(name: 'Affliction', rating: 'R', desc: 'Little Dark', length: 123)
Movie.create!(name: 'Mad Max', rating: 'R', desc: 'Fun, action', length: 154)
Movie.create!(name: 'Rushmore', rating: 'PG-13', desc: 'Quirky humor', length: 105)
puts "Created three Movies"
```

```
rake db:seed
```

This rake command will run the code in the db/seeds.rb file which will create three Movies in the DB using ActiveRecord.


***Check with the dbconsole**

```
SELECT * FROM movies;
```
**Check with rails console**

```
rails console
```

The rails console is *VERY* important for debugging and checking rails.  


Run the below commands in the Rails console.  *Notice the SQL that is created by each of the below ActiveRecord methods. 

```
Movie.first
Movie.second
Movie.third
Movie.all
```
What's going on here?

## Lab

* Create a Song resource in **this application**. Each Song will have a title, description, price and length. 

* The title is a simple string, desc is a 'text' field because it could have a lot of text. What should the price and length types be? 

* Look up the rails guide for migrations and find out.

* Create a couple of songs in the db/seeds.rb file. 

* Don't forget to use the rails dbconsole and rails console commands to verify you've created 3 songs.

## Demo: Create Movie Controller Actions and Routes.

We will implement the index, show, create, update and delete actions. 

### Index Action

**Create a movies controller in app/controllers/movies_controller.**

```
class MoviesController < ApplicationController

  # GET /movies
  def index
    # all the movies
    @movies = Movie.all
    render json: @movies
  end
end
```

**Add routes to the config/route.rb**

```
# Default root for '/' in this application
  root 'movies#index'

  get '/movies', to: 'movies#index'
```

### Show Action

**Add this to the app/controllers/movies_controller.rb**

```
# GET /movies/:id
  def show
    # find one Movie by id
    @movie = Movie.find(params[:id])

    render json: @movie
  end
```

```
# :id will identify a specific movie
  get '/movies/:id', to: 'movies#show'
```

### Params hash.

Lets take a look at the params hash.

**Add a breakpoint in the show action.**

```
def show
	byebug
    # find one Movie by id
    @movie = Movie.find(params[:id])


```

**Access http://localhost:3000/movies/1 in your browser**

This will break where we put the breakpoint 'byebug'. Look at the params hash by typing in 'params'.

Notice that it has an entry with a key of 'id' and value of '1'. This entry identifes the movie we're looking for.

Notice that the params hash always has the controller name and action name as well.

*Remove the breakpoint and go to the show the first movie again. Notice that the params hash is also show in the server logs on the command line and in the log/development.log file.*


## Lab

* Add a Songs controller with an index and show action. 

* Don't forget to check it with the rails console as well as the browser. 

* And add a breakpoint into each action and examine the params hash.


## Demo: More Controller Actions

### Create Action

**Comment this line from the app/controllers/application_controller.rb**

```
# protect_from_forgery with: :exception
```

Temporary workaround. 

**Add this to the movies controller**

```
 # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie, status: :created, location: movies_url
    else
      render json: @movie.errors, status: :unprocessable_entity
     end
  end

  private 
 
  def movie_params
    params.require(:movie)
      .permit(:name, :rating, :desc, :length)
  end
```

**Add this to your routes**

```
# Create a movie.
post '/movies', to: 'movies#create'
```

**Create a Movie, using curl**

This will send a HTTP POST request to /movies. 

The curl -d option acts like a HTML form. Giving the name of resource, movie, and it's attributes. 

```
curl -X POST -d "movie[name]=Movie 2&movie[rating]=r\
&movie[length]=124&movie[desc]=Movie 2 description" http://localhost:3000/movies
```

*Check that a new Movie was created using the rails console.*

### Strong Parameters

Notice the method movie_params. This uses the rails require and permit method to explicitly allow which incoming HTTP body parameters can be used to create a new resource. 

```
params.require(:movie)
      .permit(:name, :rating, :desc, :length)
```

Look up strong parameters in the Rails Guide. 

## Lab: Create a Song.

## Demo: More Controller Actions

### Update Action

**Add this to the movies controller**

```
# PATCH /movies/:id
  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      head :no_content
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end
```

**Add this route for update**

```
# Update a movie
patch '/movies/:id', to: 'movies#update'
```

This will update a specific movie

**Update the movie with id 2 with a new rating**

```
curl -X PATCH -d "movie[rating]=pg-13" http://localhost:3000/movies/2
```

### Delete Action

**Add this to the movies controller**

```
# DELETE /movies/:id
  def delete
    @movie = Movie.find(params[:id])
    @movie.delete

    head :no_content
  end
```

**Add this to your routes**

```
# delete a movie
delete '/movies/:id', to: 'movies#delete'
```

**Delete a movie with id of 1**

```
curl -X DELETE localhost:3000/movies/1
```

## Don't forget CORS for Cross Brower Requests

**In the Gemfile**

```
gem 'rack-cors', :require => 'rack/cors'
```


Don't forget to bundle install.


**In the config/application.rb**

```
 config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :patch, :put, :dele\
te, :options]
      end
    end

```