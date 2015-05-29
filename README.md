![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

## Objectives
* Use the resources method in the routes file to generate all the routes.
* Create a Review Model and Migration that implements a move review.
* Review the migration that implements this relationship.
* Draw an Entity Relationship Diagram(ERD) to show how foreign keys are used to implement these 1 to many relationships in the DB.
* Use ActiveRecord has_many and belongs_to to implement this relationship.
* Use the Rails console to create movie reviews.
* Create seed data to prepopulate a couple of movie reviews.
* Create a Review's controller that will return a JSON representation of movie reviews.
* Create a nested resource for movie reviews.

## Setup

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

Ok, you should now be able to see the JSON for all three movies at `http://localhost:3000`.

## Demo: Create movies routes using 'resources'

Previously, we were creating routes for each Movie Controller action. *This is tedious.* Let's see how we can make this more concise.

But, first lets look at all of routes!

```
rake routes
```

**Change config/routes to**

```ruby
Rails.application.routes.draw do
  # Default root for '/' in this application                                    
  root 'movies#index'

  # create routes for movie resource                                            
  resources :movies, except: [:new, :edit]
end
```

The 'resources' method will automatically generate all the routes we've creating individually. *Much better.*

In another terminal run rake routes again and compare the routes.

```
rake routes
```

