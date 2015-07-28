![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

Rails: `has_many` \& `belongs_to`
=================================

So far you've seen how to associate records with on another using foreign keys in a database. Just as we can use ActiveRecord to read, change, update, and delete data from our database, we can use ActiveRecord relationship methods to associate records with one another using Ruby code.

Objectives
----------

* Digram the database tables and Entity Relationship Diagram that describe a parent-child relationship.
* Write a migration for a parent-child relationship.
* Associate plain Ruby objects with one another.
* Compare `has_many` and `belongs_to` to other macros, like `attr_accessor`.
* Configure ActiveRecord to manage parent-child relationships using `has_many` and `belongs_to`.
* Create associated records using the rails console.

Instructions
------------

Fork and clone this repo. Change into the appropriate directory and update dependencies.

Next, create your database, migrate, and seed. Start your web server.

Follow along with your instructor, closing your laptop if requested.

Entity Relationship Diagrams (ERDs)
-----------------------------------

It is often useful to organize our thoughts about the entities in our application before we generate models and migrations. We'll use a simplified diagram syntax that is derived from [UML](http://www.uml.org).

**NOTE:** If you look into data modeling on your own, you might run across some terms that people in the rails community don't often use. These include describing relationships using plurals ("one-to-many", "many-to-many", "many-to-one", etc.). Because rails uses common-language names for its relationship macros (`has_many` and `belongs_to`), these general terms are sometimes preferred since they are not loaded with the concept of "ownership". I will often refer to these as parent-child relationships since "one-to-many" relationships are the basis of hierarchical structures. Finally, "parent" objects can be thought of as "containers" or "collections", like folders in the file system.

We'll list our entities in boxes and draw arrows denoting the relationships. We denote number on the end of the tails to communicate the type of relationship we are defining.

Exercise: ERDs
--------------

First, diagram the database schema for `people`, `places`, and `pets`. Where are foreign keys stored? What are the names of the foreign key columns?

Next, I'll show you the relationship between `Person` and `Pet`. Then, you'll diagram the relationship between `Person` and `Place`. What is the top-level container as modeled? Is this clearly a hierarchical series of relationships?

Can we access `Pet` from `Place`?

Exercise: Migrations
--------------------

**REVIEW:** Generate a migration for `pets`. `pets` should have a `name`, a `species`, and a `dob`.

After you generate the migration, inspect it visually and if it looks right, run `rake db:migrate`. Next enter `rails db` and inspect the `pets` table with `\d pets`. Do the columns look as you'd expect? Your output should resemble:

```txt
                                     Table "public.pets"
   Column   |            Type             |                     Modifiers
------------+-----------------------------+---------------------------------------------------
 id         | integer                     | not null default nextval('pets_id_seq'::regclass)
 name       | character varying           |
 species    | character varying           |
 dob        | character varying           |
 created_at | timestamp without time zone | not null
 updated_at | timestamp without time zone | not null
Indexes:
    "pets_pkey" PRIMARY KEY, btree (id)
```

**RESEARCH:** Write a migration to associate `people` with `pets`. Next, write a migration to associate `people` with `places`. After writing each migration, inspect the migration and run `rake db:migrate`. If you need to make changes, run `rake db:rollback`, edit the migration, and re-run the migrations. If you get too far ahead, you'll need to reset, or "nuke and pave", your database after editing migrations. To "nuke and pave":

```txt
rake db:drop db:create db:migrate db:seed
```

**NOTE:** There is more than one way to write association migrations. You can write your migrations and column names by hand, or you can use a special migration syntax to auto-generate the migration for you. If you write your migrations by hand, be sure to add the appropriately named column, add an index, and add a foreign key constraint. If you use the special generator syntax, this will be done for you.

* In [ActiveRecord Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html), search for "references" in [section 2.1](http://edgeguides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration).
* Also see [section 2.7](http://guides.rubyonrails.org/association_basics.html#choosing-between-belongs-to-and-has-one) in [ActiveRecord Associations](http://guides.rubyonrails.org/association_basics.html).

Enter `rails db` and inspect each altered table after you run your migrations. After running the migration for associating `people` with `pets`, the `pets` table should resemble:

```txt
                                     Table "public.pets"
   Column   |            Type             |                     Modifiers
------------+-----------------------------+---------------------------------------------------
 id         | integer                     | not null default nextval('pets_id_seq'::regclass)
 name       | character varying           |
 species    | character varying           |
 dob        | character varying           |
 created_at | timestamp without time zone | not null
 updated_at | timestamp without time zone | not null
 person_id  | integer                     |
Indexes:
    "pets_pkey" PRIMARY KEY, btree (id)
    "index_pets_on_person_id" btree (person_id)
Foreign-key constraints:
    "fk_rails_88e11d1ea7" FOREIGN KEY (person_id) REFERENCES people(id)
```

After running the migration to associate `places` with `people`, the `people` table should resemble:

```
                                      Table "public.people"
   Column    |            Type             |                      Modifiers
-------------+-----------------------------+-----------------------------------------------------
 id          | integer                     | not null default nextval('people_id_seq'::regclass)
 surname     | character varying           |
 given_name  | character varying           |
 gender      | character varying           |
 dob         | character varying           |
 created_at  | timestamp without time zone | not null
 updated_at  | timestamp without time zone | not null
 middle_name | character varying           |
 place_id    | integer                     |
Indexes:
    "people_pkey" PRIMARY KEY, btree (id)
    "index_people_on_place_id" btree (place_id)
Foreign-key constraints:
    "fk_rails_6f429ca703" FOREIGN KEY (place_id) REFERENCES places(id)
Referenced by:
    TABLE "pets" CONSTRAINT "fk_rails_88e11d1ea7" FOREIGN KEY (person_id) REFERENCES people(id)
```

Plain Ruby Associations
-----------------------

Now that we have foreign keys in place for our relationships, we can use ActiveRecord to associate different records with one-another. However, we should pause to understand what associations look like *in-memory* before saving them to the database.

Suppose we don't have a database backing our app. Just as we modeled objects when learning about object-oriented programming, we can model associations using the concept of "collection" properties on parent objects. After inspecting these examples, I hope you realize there's not much special about ActiveRecord associations other than the setters, getters, and persistence callbacks they provide.

Let's start by modeling a `Person` with a plain Ruby object (a plain Ruby object is just an object that doesn't inherit directly from rails). In this simplified example, we want to set a person's `given_name` and `surname` when creating an instance, and we also want to have access to a `pets` property that holds an array of `Pet` objects (we'll define `Pet` in a moment).

```ruby
class Person
  attr_reader :given_name, :surname
  attr_accessor :pets

  def initialize(given_name, surname)
    @given_name, @surname = given_name, surname
    @pets = []
  end
end
```

Next, let's define `Pet`. A pet has a `name` and a `species` when instantiated, and also has an `owner` property that we can access to set the pet's only `owner`.

```ruby
class Pet
  attr_reader :name, :species
  attr_accessor :owner

  def initialize(name, species)
    @name, @species = name, species
    @owner = nil
  end
end
```

Now, let's create a `Person` and a `Pet`, and associate them with one-another. We associate objects by creating a reference to the associated object in a property on the host object. In our example, we'll create a new `Pet` and a new `Person`, and save the new pet as part of the `Person#pets` collection. We'll also save the new person as in `Pet#owner`. The reason we do both is to have access to the associated object now matter whether we have a `Pet` or `Person` at hand.

```ruby
jeff = Person.new("Jeff", "Horn")
lucky = Pet.new("Lucky", "cat")

jeff.pets << lucky
lucky.owner = jeff

jeff.pets[0] == lucky
lucky.owner == jeff

lucky.owner.pets[0] == lucky
```

In the last few lines, we see that the object referenced as the first member of the `pets` collection on `jeff` is the same instance we added previously. Additionally, we can see that always have access to associated objects no matter where we are in an access chain.

Take a moment and digram an ERD for these object relationships. Is it any different from the ERD that associated `Pet` and `Person` before? What can we conclude about the usefulness of ERDs for modeling relationships?

Rails: `has_many`
-----------------

Including `has_many` in an ActiveRecord model defines a series of methods on the model for accessing an associated **collection** of objects. For example, if we have a `Firm` model and include `has_many :clients`, we will be able to get a particular consultant's entire set of clients by `Firm.find(1).clients`.

Just like `attr_accessor`, `has_many` is a macro that defines methods for us. You can think of the methods it defines as specialized setters and getters, as well as additional methods for dealing with database records. A list of all the methods generated by `has_many` can be found in the [ActiveRecord::Associations::ClassMethods documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many).

Supposing a `Firm` that `has_many :clients`, the list of generated methods is:

1. `Firm#clients`
1. `Firm#clients<<`
1. `Firm#clients.delete`
1. `Firm#clients.destroy`
1. `Firm#clients=`
1. `Firm#client_ids`
1. `Firm#client_ids=`
1. `Firm#clients.clear`
1. `Firm#clients.empty?`
1. `Firm#clients.size`
1. `Firm#clients.find`
1. `Firm#clients.exists?(name: 'ACME')`
1. `Firm#clients.build`
1. `Firm#clients.create`
1. `Firm#clients.create!`

Exercise: `has_many` Methods
----------------------------

Each of you will research one method. Describe what the method does in your own words. Is it a setter, a getter, or something else? Then, give an example of another one-to-many relationship, where you would define `has_many`, and how you would use the method you just researched.

Rails: `belongs_to`
-------------------

Including `belongs_to` in an ActiveRecord model defines a series of methods on the model for accessing a **single** associated object. For example, if we have a `Post` model and include `belongs_to :author`, we will be able to get a particular post's author by `Post.find(1).author`.

How do you decide where to put the `has_many` and `belongs_to` macros? Well, you can ask yourself a few questions:

1. Is the model associated with a collection? If yes, include `has_many`.
1. Is the model associated with a single object? If yes, include `has_one` or `belongs_to`.
1. Does the model's database table hold a foreign key column? If yes, include `belongs_to`.

The "children" in parent-child relationships, or the "many" in one-to-many relationships hold the foreign key, and therefore will need `belongs_to` on the ActiveRecord model.

`belongs_to` defines several methods for us. A list of the methods generated by `belongs_to` can be found in the [ActiveRecord::Associations::ClassMethods documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to)

Supposing a `Post` that `belongs_to :author`, the list of generated methods is:

1. `Post#author`
1. `Post#author=(author)`
1. `Post#build_author`
1. `Post#create_author`
1. `Post#create_author!`

Exercise: `belongs_to` Methods
----------------------------

Each of you will research one method. Describe what the method does in your own words. Is it a setter, a getter, or something else?

Exercise: Creating Associated Records
-------------------------------------

We need to set up ActiveRecord to handle our one-to-many relationship from `Person` to `Pet`. Open `app/models/person.rb` and add edit it.

```ruby
class Person < ActiveRecord::Base
  has_many :pets, inverse_of: :person
end
```

It is best practice to include `inverse_of` options on each of our associations. It helps rails keep memory in-sync with changes in the database. In this case, `Pet` is a many-to-one relationship with `Person`, so we use the plural `:pets` and the singular `:person`.

Next, create `app/models/pet.rb`.

```ruby
class Pet < ActiveRecord::Base
  belongs_to :person, inverse_of: :pets
end
```

In this case, we read our relationship in the other direction. `Person` is a one-to-many relationship with `Pet`, so we use the singular `:person` and the plural `:pets`.

Since we've already completed our migration that adds `person_id` to the `pets` table, we can use ActiveRecord association setter methods to create an association between a person and a pet.

Enter `rails db`. Query the `pets` table. It should be empty.

Exit and then enter `rails console`.

```ruby
jeff = Person.create!(given_name: "Jeffrey", surname: "Horn")
lucky = Pet.create!(name: "Lucky", species: "cat")

jeff.pets << lucky
```

Exit and re-enter `rails db`. Query the `pets` table and the `person` table. The `person_id` in the `pets` table for the pet you just created should equal the `id` in the `people` table for the person you just created.

Exit and re-enter `rails console`.

```ruby
lucky = Pet.last
jeff = Person.last

lucky.person == jeff
```

The last line should return `true`. ActiveRecord took care of setting up the association in both directions.

Lab: Creating Associated Records
-------------------------------------

Create the relationship between `Person` and `Place` by putting `has_many` and `belongs_to` in the appropriate models. Don't forget your `inverse_of` options. Note that we've already created the migrations we needed at the beginning of this lesson.

Test your associations by adding a person to a place through the `rails console`. Inspect the data in `rails db`. Does it look as you'd expect?

Now, try creating an association in the opposite direction: add a place to a different person and check your changes.

Resources
---------

* [Rails Association Basics](http://guides.rubyonrails.org/association_basics.html) Read the sections on belongs_to and has_many.
* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Rails Documentation](http://api.rubyonrails.org/)
* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)
* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/)
