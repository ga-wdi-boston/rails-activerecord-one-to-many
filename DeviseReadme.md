## User Registration and Authentication.


### Objectives  

* Register users.  
* Authenticate users.  
* Use the Devise gem.  

### Devise 
We're are going to use the Devise gem to implement registration and authentication.  

Devise is one of many ways to implement [authentication](https://www.ruby-toolbox.com/categories/rails_authentication) in Rails. It is very popular. 

Or you can "roll your own" [authentication/login](http://railscasts.com/episodes/270-authentication-in-rails-3-1). 


### Registration
We are going allow users to register with our app. They are going to enter their credentials, _email and password_, to create a account.


### Authentication/Login

We are going to add authentication to a Rails app. Authentication is sometimes called _login_. 

##### Authentication is NOT Authorization
A _very_ typical miscomprehension is that login/authentication is the same as authorization.

Authentication is the ability to determine the indenity of someone based on a set of credentials such as a username, email and a password.

Authorization is allowing/restricting or constraining some set of behavior or operations based on the "role" being played by a user. Typically, this is done using Roles as in Role Base Authorization Control, (RBAC). 

Some popular gems that are used to implement [Authentication](https://www.ruby-toolbox.com/categories/rails_authorization) are Cancan and Pundit.

## Devise

* Add the devise gem to the Gemfile and bundle.  
	```
	gem 'devise'
	```

### Install/Setup
* Setup Devise in your app. Follow the directions in the install.
   
	`rails g devise:install`

* Add flash handing to the Layout, above the yield  

```
 <% flash.each do |name, msg| %>  
   <% if msg.is_a?(String) %>  
     <%= content_tag :div, msg, :class => "flash_#{name}" %>  
   <% end %>  
 <% end %>  
```

* [Optional] Copy the Devise views to your app.



#### Look at the i18n YAML internationalization file that will define messages for Devise.
open config/locales/devise.en.yml

#### Look at the initialization file.
open config/initializers/devise.rb

### Generate a User model 

```	
rails generate devise User
```
	
#### Look at the migrations file.
open db/migrate/...

Notice that some fields are commented out. This is because they are _ONLY_ needed by certain devise models.

In this case confirmation and lockout features of Devise are not being used. But, they may be in the future. If so, create migrations to add these attributes.

#### Lets Look at the User model.
We're using a couple of devise modules. See Devise Modules below.	
#### Look at the routes.rb file and run rake routes.

In the config/routes.rb file you will see a 'devise_for :users' is added. This generates a whole set of routes that devise will use.  Run

```
rake routes
```



You should see many new routes. And they reference controllers that are __NOT__
in your app? 

Where are they?

#### Run rake db:migrate
For the User model. And take a look at the schema.rb



## Devise Modules
* database-authenticatable  	Handles authentication of a user, as well as password encryption.
* confirmable  	Adds the ability to require email confirmation of user accounts.
* lockable  	Can lock an account after n number of failed login attempts. 
* recoverable   
	Provides password reset functionality.
* registerable  	Alters user sign up to be handled in a registration process, along with account management.* rememberable  	Provides remember me functionality. 
* timeoutable  	Allows sessions to be expired in a configurable time frame.* trackable:	Stores login counts, timestamps, and IP addresses.* validatable	Adds customizable validations to email and password.* omniauthable	Adds Omniauth2 support


## User Sessions


A User will have a "session" with the application after they have successfully
logged in. This session will typically last for a specific period of time, _session timeout_. 

For example, if the user hasn't interacted with the site for > 30 minutes. 

The session is a hash that contains a very _limited_ set of data about a user that will be shared between the client/browser and the server in a cookie. This can be the only state that persist between HTTP Requests.  

For example, the session will have the current user's id. This is typically the primary key for that user in the users table. And this user id will be used to look up a User on each Request. _Setting the current_user_. 


Devise provides a way to handle Session resources. Running rake routes will show you what Devise provides to manage a user's session.

_Show me the form to login and create a session_  

```
 new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
```

_Create a session for this logged in user_

```
 user_session POST   /users/sign_in(.:format)       devise/sessions#create
 ```
 

_Delete the session for a user_  

```
destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
```

So, we now have a set of routes a controller and a login form for the Session.

## User registration
Devise can manage the registration of users. Which types of features an application can use can be configured by Devise.  


<table>
	<thead>
		<th>URL Helper</th><th>HTTP Method</th><th>Path</th><th>Controller#Action</th>
	</thead>
	<tbody>
	<tr>
		<td>cancel_user_registration</td>
		<td>GET</td><td>/users/cancel(.:format)</td>
		<td>devise/registrations#cancel
		</td>
	</tr>

	<tr>
		<td>user_registration</td><td>POST</td>
		<td>/users(.:format)</td>
		<td>devise/registrations#create</td>
	</tr>

	<tr>
		<td>new_user_registration</td>
		<td>GET</td>
		<td>/users/sign_up(.:format)</td>
		<td>devise/registrations#new</td>
	</tr>

	<tr>
		<td>edit_user_registration</td>
		<td>GET</td><td>/users/edit(.:format)</td>
		<td>devise/registrations#edit</td>
	</tr>

	<tr>
		<td></td>
		<td>PATCH</td>
		<td>/users(.:format)</td>
		<td>devise/registrations#update</td>
	</tr>

	<tr>
		<td></td>
		<td>PUT</td>
		<td>/users(.:format)</td>
		<td>devise/registrations#update</td>
	</tr>

	<tr>
		<td></td>
		<td>DELETE</td>
		<td>/users(.:format)</td><td>devise/registrations#destroy</td>
	</tr>
</tbody>
</table>



## Startup the app.
	`rails s -p 3333`


## Add login/logout links to Layout  

```
 <div>
     <% if user_signed_in? %>
      Logged in as <strong><%= current_user.email %></strong>.
      <%= link_to 'Edit profile', edit_user_registration_path %> |
      <%= link_to "Logout", destroy_user_session_path, method: :delete %>
    <% else %>
      <%= link_to "Sign up", new_user_registration_path %> |
      <%= link_to "Login", new_user_session_path %>
    <% end %>
 </div>
```




## Add the Devise views to your app.
	`rails g devise:views`
	
This will copy the views that are typically in the Devise gem to your app. Then you can modify these views as needed.

Lets look at a couple of these.
  


### References

* [Railscast Devise Authentication](http://railscasts.com/episodes/209-devise-revised)
* [Railscast Authentication from Scratch](http://railscasts.com/episodes/250-authentication-from-scratch-revised)



