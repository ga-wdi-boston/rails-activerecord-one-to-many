![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# Homework

Now that you know ActiveRecord Associations `has_many` and `belongs_to`, go back into your blog app, create two new Models:

* Category: a post `belongs_to` a category. A category `has_many` posts. A category has a name.
* Suggest Reading: a suggested reading `belongs_to` a post. A post `has_many` suggested readings. A suggested reading is a link with an address and a title.

# Instructions

* Complete the following user stories. A user story is *not* complete unless the story is performable via the browser; being performable via the console is not enough.
* By the end of this exercise:
  * You should have a working category feature and a working suggested readings feature.
  * You should have category views that all posts within a particular category.
  * You should have a view for individual blog posts that displays the post's title, post's body, suggested readings, and comments. You should have a link to add a new reading beneath the listed readings, and a link to create a new comment under the listed comments.

# Notes

* Your blog entries may be called "articles" instead of "posts".
* Your "suggested readings" may be called "links" instead.
* You will not need to create any forms on the `post/show` page. You should be able to click a link from the post in order to create a new comment or link.
* You should create controllers and views for both categories and suggested readings. You may not need all seven CRUD actions. You may not need all four CRUD views.

# User Stories

## Category Feature

* As a reader, when I visit the home page, I want to see a list of all the categories.
* As a reader, when I visit a category, I want to see a list of all the posts in the given category. 
* As a reader, when I visit a post, I want to see the category a post belongs to.

* As an author, I want to add a new category to the list of available categories.
* As an author, I want to specify a category for an existing post. 
* As an author, I want to edit the category for an existing post. 
* As an author, I want to delete the category for an existing post.
* As an author, when I delete a category, all of its associated posts should also be deleted.

## Suggested Readings Feature

* As a reader, when I visit a post, I want to see all the suggested readings belonging to that post.

* As an author, I want to add a new link to an existing post. 
* As an author, I want to edit an existing link. 
* As an author, I want to delete an existing link.
* As an author, when I delete a post, all of its associated suggested readings should also be deleted.

# Bonus

Give your `posts/show` view a form for adding a new comment. The form should appear directly after the comments are displayed. 
