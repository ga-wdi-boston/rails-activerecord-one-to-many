![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

Rails: `has_many` \& `belongs_to`
=================================

So far you've seen how to associate records with on another using foreign keys in a database. Just as we can use ActiveRecord to read, change, update, and delete data from our database, we can use ActiveRecord relationship methods to associate records with one another using Ruby code.

Objectives
----------

* Digram the database tables and Entity Relationship Diagram that describe a parent-child relationship.
* Associate plain Ruby objects with one another.
* Write a migration for a parent-child relationship.
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



Rails: `belongs_to`
-------------------



Exercise: Creating Associated Records
-------------------------------------



Resources
---------

* [Rails Association Basics](http://guides.rubyonrails.org/association_basics.html) Read the sections on belongs_to and has_many.
* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Rails Documentation](http://api.rubyonrails.org/)
* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)
* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/)
