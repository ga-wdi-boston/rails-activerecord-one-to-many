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

Next, I'll show you the relationship between `Person` and `Pet`. Then, you'll diagram the relationship between `Person` and `Place`.

Can we access `Pets` from `Place`?


Resources
---------

* [Rails Association Basics](http://guides.rubyonrails.org/association_basics.html) Read the sections on belongs_to and has_many.
* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Rails Documentation](http://api.rubyonrails.org/)
* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)
* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/)
