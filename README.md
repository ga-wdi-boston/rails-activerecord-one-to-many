# Multi-Author Publication with Comments

## Setup

I have already ran `rails new SharedBlog --database=postgresql -T
` to setup the homework, but that is all.

## Instructions/Assignment

### Overview

You will create a website which has many articles about various topics. Each article has one author, but many comments. The comments are left anonymously and don't have an author.

### Specifics

From the browser, you should be able to:

- Create a new User. **Do not implement user login or make this a secure system.**
- View a list of all users
- View a single user, and on that page see the titles and truncated body of all of their articles. There should be a 'New Article' button on this page, which allows you to create a new Article as if you were that user.
- Your root route should show a listing of all articles (with the most recent at the top), with their title, number of comments, author's name, and a short snippet of the body. From here, you should be able to click on an author and view their Show page, or click on the title of the Article and view the entire Article and its comments
- Anyone should be able to leave comments on an Article anonymously. These comments are visible on the Show page of that article. Comments cannot be deleted or edited once created.
- You should be able to edit an Article
- Use *nested routes* where appropriate for helping create new articles and similar.

Think about the following potential URLs which you may find inspiring...

* `POST http://localhost:3000/authors/4/articles/16/comments`
* `GET http://localhost:3000/authors/2/articles/new`

**Do not attempt to implement user login**

Below is a recommended/potential layout for the models and database.

![ERD Diagram](http://i.imgur.com/yf0j4VZ.png "Suggested model layout")

## Bonus 1

Implement [Bootstrap](http://getbootstrap.com/) to make it look good

## Bonus 2

Refactor the above code, and figure out how to use [Devise](https://github.com/plataformatec/devise) for user login. The documentation for Devise is ok, but overall in a poor order.

## Bonus 3

Figure out how to deploy this to Heroku. You'll need to create a free account. The documentation for Heroku is excellent.
