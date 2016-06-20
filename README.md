![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# Rails ActiveRecord: one-to-many relationships

So far you've seen how to associate records with one another using foreign keys
 in a database.
Just as we can use ActiveRecord to read, change, update, and delete data from
 our database, we can use ActiveRecord relationship methods to associate records
 with one another using Ruby code.

## Objectives

-   Digram the database tables and Entity Relationship Diagram that describe a
 one-to-many relationship.
-   Write a migration for a one-to-many relationship.
-   Associate plain Ruby objects with one another.
-   Compare `has_many` and `belongs_to` to other macros, like `attr_accessor`.
-   Configure ActiveRecord to manage one-to-many relationships using `has_many`
 and `belongs_to`.
-   Create associated records using the rails console.

## Instructions

Fork, clone, branch (training), and `bundle install`.

Then create the database and run migrations.

## Relationship Diagram

Lets diagram relationships on a whiteboard.

In Rails, the class that is on the "one" side of "one-to-many" uses the
 `has_many` macro.
The class on the "many" side uses `belongs_to`.
These may be referred to as "parent-child" relationships since "one-to-many" can
 be the basis of a hierarchy.
Also, "parent" objects can be thought of as "containers" for "collections" of
 "children", similar to folders in the file system.

We'll list our entities in boxes and draw arrows denoting the relationships.
We denote number on the end of the tails to communicate the type of relationship
 we are defining.

### Discussion: Table relationships for Albums and Songs

Firstly, lets discuss what the schema consists of for our Albums and Songs
tables from the previous training. What would the foreign key be? Where would it
be stored? What would the names of the foreign keys be?

### Demo: Album and Songs

Watch as we make a relationship for Album and Songs.

### Lab: Table relationships

Now, take some time to diagram the database schema for `people`, `cities`, and
`pets`. Where are foreign keys stored? What are the names of the foreign key
columns?

### Discussion: Person and Pet

We'll look at the relationship between `Person` and `Pet`.

### Lab: Person and City

We'll diagram the relationship between `Person` and `City`.

-   What is the top-level container as modeled?
-   Is this clearly a hierarchical series of relationships?
-   Can we access `Pet` from `City`?

### Lab: Migrations

**REVIEW:** Generate a model for `pets` using the first line of
 `data/pets.csv` as attribute names.

After you generate the model, inspect the migration visually and if it looks
right, run `rake db:migrate`. Next enter `rails db` and inspect the `pets` table
with `\d pets`.

Do the columns look as you'd expect? Your output should resemble:

```txt
                                     Table "public.pets"
   Column   |            Type             |                     Modifiers
------------+-----------------------------+---------------------------------------------------
 id         | integer                     | not null default nextval('pets_id_seq'::regclass)
 born_on    | date                        |
 kind       | character varying           |
 name       | character varying           |
 created_at | timestamp without time zone | not null
 updated_at | timestamp without time zone | not null
Indexes:
    "pets_pkey" PRIMARY KEY, btree (id)
```

Load the data for people, cities, and pets using:

```sh
rake db:seed
```

**RESEARCH:** Write a migration to associate `pets` with `people` as `owner`.
Next, write a migration to associate `people` with `cities` as `born_in`.
After writing each migration, inspect the migration and then run `rake
 db:migrate`.
If you need to make changes, run `rake db:rollback`, edit the migration, and
 re-run the migrations.
If you get too far ahead, you'll need to reset, or "nuke and pave",
 your database after editing migrations.
To "nuke and pave":

```sh
rake db:drop db:create db:migrate db:seed
```

There is more than one way to write association migrations.
You can write your migrations and column names by hand, or you can use a special
 migration syntax to auto-generate the migration for you.
If you write your migrations by hand, be sure to add the appropriately named
 column, add an index, and add a foreign key constraint.
If you use the special generator syntax, this will be done for you.

**NOTE:** If you want non-default names, as we do for `owner` and `born_in`,
 you'll need to edit the migration to use the extended syntax.

-   In [ActiveRecord Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html),
 search for "references" in [section 2.1](http://guides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration).
-   Also see [section 2.7](http://guides.rubyonrails.org/association_basics.html#choosing-between-belongs-to-and-has-one) in [ActiveRecord Associations](http://guides.rubyonrails.org/association_basics.html).

Enter `rails db` and inspect each altered table after you run your migrations.
After running the migration for associating `people` with `pets`, the `pets`
table should resemble:

```text
                                     Table "public.pets"
   Column   |            Type             |                     Modifiers
------------+-----------------------------+---------------------------------------------------
 id         | integer                     | not null default nextval('pets_id_seq'::regclass)
 name       | character varying           |
 kind       | character varying           |
 dob        | character varying           |
 created_at | timestamp without time zone | not null
 updated_at | timestamp without time zone | not null
 owner_id   | integer                     |
Indexes:
    "pets_pkey" PRIMARY KEY, btree (id)
    "index_pets_on_owner_id" btree (owner_id)
Foreign-key constraints:
    "fk_rails_88e11d1ea7" FOREIGN KEY (owner_id) REFERENCES people(id)
```

After running the migration to associate `cities` with `people`, the `people`
 table should resemble:

```text
                                      Table "public.people"
   Column    |            Type             |                      Modifiers
-------------+-----------------------------+-----------------------------------------------------
 id          | integer                     | not null default nextval('people_id_seq'::regclass)
 surname     | character varying           |
 given_name  | character varying           |
 gender      | character varying           |
 height      | integer                     |
 weight      | integer                     |
 born_on     | date                        |
 created_at  | timestamp without time zone | not null
 updated_at  | timestamp without time zone | not null
 born_in_id  | integer                     |
Indexes:
    "people_pkey" PRIMARY KEY, btree (id)
    "index_people_on_born_in_id" btree (born_in_id)
Foreign-key constraints:
    "fk_rails_6f429ca703" FOREIGN KEY (born_in_id) REFERENCES cities(id)
Referenced by:
    TABLE "pets" CONSTRAINT "fk_rails_88e11d1ea7" FOREIGN KEY (owner_id) REFERENCES people(id)
```

## Plain Ruby Associations

Now that we have foreign keys in city for our relationships, we can use
 ActiveRecord to associate different records with one-another.
However, we should pause to understand what associations look like *in-memory*
 before saving them to the database.

Suppose we don't have a database backing our app.
Just as we modeled objects when learning about object-oriented programming,
 we can model associations using the concept of "collection" properties on
 parent objects.

### Code along: In memory associations

Let's start by modeling a `Person` with a plain Ruby object (a plain Ruby object
 is just an object that doesn't inherit directly from rails).
In this simplified example, we want to set a person's `given_name` and `surname`
 when creating an instance, and we also want to have access to a `pets` property
 that holds an array of `Pet` objects (we'll define `Pet` in a moment).

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

Next, let's define `Pet`. A pet has a `name` and a `kind` when instantiated,
 and also has an `owner` property that we can access to set the pet's only
 `owner`.

```ruby
class Pet
  attr_reader :name, :kind
  attr_accessor :owner

  def initialize(name, kind)
    @name, @kind = name, kind
    @owner = nil
  end
end
```

Now, let's create a `Person` and a `Pet`, and associate them with one-another.
We associate objects by creating a reference to the associated object in
 property on the host object.
In our example, we'll create a new `Pet` and a new `Person`, and save the new
 pet as part of the `Person#pets` collection.
We'll also save the new person as in `Pet#owner`.
The reason we do both is to have access to the associated object now matter
 whether we have a `Pet` or `Person` at hand.

```ruby
jane = Person.new("Jane", "Jones")
lucky = Pet.new("Lucky", "cat")

jane.pets << lucky
lucky.owner = jane

jane.pets[0] == lucky
lucky.owner == jane

lucky.owner.pets[0] == lucky
```

In the last few lines, we see that the object referenced as the first member of
 the `pets` collection on `jane` is the same instance we added previously.
Additionally, we can see that always have access to associated objects no matter
 where we are in an access chain.

Take a moment and diagram these object relationships.
Is it any different from the diagram that associated `Pet` and `Person` before?

After inspecting these examples, I hope you realize there's not much special
 about ActiveRecord associations other than the setters, getters, and
 persistence callbacks they provide.

## Rails: `has_many`

Including `has_many` in an ActiveRecord model defines a series of methods on the
 model for accessing an associated **collection** of objects.
For example, if we have a `Firm` model and include `has_many :clients`, we will
 be able to get a particular consultant's entire set of clients by
 `Firm.find(1).clients`.

Just like `attr_accessor`, `has_many` is a macro that defines methods for us.
You can think of the methods it defines as specialized setters and getters, as
 well as additional methods for dealing with the database.
A list of all the methods generated by `has_many` can be found in the [ActiveRecord::Associations::ClassMethods documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many).

Supposing a `Firm` that `has_many :clients`, the list of generated methods is:

1.  `Firm#clients`
1.  `Firm#clients<<`
1.  `Firm#clients.delete`
1.  `Firm#clients.destroy`
1.  `Firm#clients=`
1.  `Firm#client_ids`
1.  `Firm#client_ids=`
1.  `Firm#clients.clear`
1.  `Firm#clients.empty?`
1.  `Firm#clients.size`
1.  `Firm#clients.find`
1.  `Firm#clients.exists?`
1.  `Firm#clients.build`
1.  `Firm#clients.create`
1.  `Firm#clients.create!`

### Lab: `has_many` Methods

Each squad will research a few of the above methods.

-   Describe what the method does.
-   Is it a setter, a getter, or something else?
-   Give an example of another one-to-many relationship, where you would define
 `has_many`, and how you would use the method you just researched.

## Rails: `belongs_to`

Including `belongs_to` in an ActiveRecord model defines a series of methods on
 the model for accessing a **single** associated object.
For example, if we have a `Post` model and include `belongs_to :author`, we will
 be able to get a particular post's author by, e.g., `Post.find(1).author`.

How do you decide where to put the `has_many` and `belongs_to` macros?
Well, you can ask yourself a few questions:

1.  Is the model associated with a collection? If yes, include `has_many`.
1.  Is the model associated with a single object? If yes, include `has_one` or
 `belongs_to`.
1.  Does the model's database table hold a foreign key column?
 If yes, include `belongs_to`.

The "many" in one-to-many relationships, or the "children" in parent-child
 relationships, hold the foreign key and will need `belongs_to` on the
 ActiveRecord model.

`belongs_to` defines several methods for us. A list of the methods generated by
 `belongs_to` can be found in the [ActiveRecord::Associations::ClassMethods documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to).

Supposing a `Post` that `belongs_to :author`, the list of generated methods is:

1.  `Post#author`
1.  `Post#author=(author)`
1.  `Post#build_author`
1.  `Post#create_author`
1.  `Post#create_author!`

## Code along: Creating Associated Records

We need to set up ActiveRecord to handle our one-to-many relationship from
 `Person` to `Pet`. First we have to create a Pet Model (and table).

 `bundle exec rails g model Pet born_on:string kind:string name:string`

Then we have to migrate the newly create model:
`bundle exec rake db:migrate`

Once the model has been created and the migrate has been executed, Open
`app/models/person.rb` and edit it.

```ruby
class Person < ActiveRecord::Base
  has_many :pets, inverse_of: :owner, foreign_key: 'owner_id'
end
```

It is best practice to include `inverse_of` options on each of our associations.
It helps rails keep memory in-sync with changes in the database.
In this case, `Pet` is a many-to-one relationship with `Person`, so we use the
 plural `:pets` and the singular `:owner`.
Because we're not using the default name for the relationship, we need to pass
 the `foreign_key` option.

Next, open `app/models/pet.rb`.

```ruby
class Pet < ActiveRecord::Base
  belongs_to :owner, inverse_of: :pets, class_name: 'Person'
end
```

In this case, we read our relationship in the other direction.
`Person` is a one-to-many relationship with `Pet`, so we use the singular
 `:owner` and the plural `:pets`.
Again, because we're not using the default name for the relationship, we need to
 pass the `class_name` option.

Since we've already completed our migration that adds `owner_id` to the `pets`
 table, we can use ActiveRecord association setter methods to create an
 association between a person and a pet.

Enter `rails db`. Query the `pets` table. The `owner_id` column should be empty.

Exit and enter the `rails console`.

```ruby
joan = Person.first
blingo = Pet.forty_two

joan.pets << blingo
```

Exit and re-enter `rails db`. Query the `pets` table and the `person` table.
The `owner_id` in the `pets` table for "Blingo" should equal
 the `id` in the `people` table for "Joan".

Exit and re-enter `rails console`.

```ruby
blingo = Pet.forty_two
joan = Person.first

blingo.owner == joan
```

The last line should return `true`.
ActiveRecord took care of setting up the association in both directions.

## Lab: Creating Associated Records

Create the relationship between `Person` and `City` by putting `has_many` and
 `belongs_to` in the appropriate models.
Don't forget your `inverse_of` options.
Note that we've already created the migrations we needed at the beginning of
 this lesson.

Test your associations by adding a person to a city through the
 `rails console`.
Inspect the data in `rails db`. Does it look as you'd expect?

Now, try creating an association in the opposite direction: add a city to a
 different person and check your changes.

## Resources

-   [Rails Association Basics](http://guides.rubyonrails.org/association_basics.html)
 Read the sections on belongs_to and has_many.
-   [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)
-   [Rails Documentation](http://api.rubyonrails.org/)
-   [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)
-   [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/)

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.
