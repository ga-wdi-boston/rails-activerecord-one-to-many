# Many to Many Relationships

### Objectives
* Create many to many relationship.
* 


## Create some Users
In the seed.rb file add.

```
User.delete_all
puts 'Creating Users'  
User.create!(email: 'joe@example.com', password: 'password')  
User.create!(email: 'jill@example.com', password: 'password')  
User.create!(email: 'tom@example.com', password: 'password')  
```


## Add a User - Album Many to Many relationship
 `r g model ManagedAlbums user:belongs_to album:belongs_to role`
 
 In the User model, user.rb add.  
 	```
  	has_many :managed_albums 
	has_many :albums, through: :managed_albums
	```

In the seed file add.  

```
joe = User.first  
joe.albums.create!(title: "Beck Ola")
joe.albums << Album.find_by_name('Sea Change')
joe.albums << Album.find_by_name('Nevermind')
```


### Allow users the ability see their managed albums.
Add the below to the Album index action.  

```
 if current_user  
      @articles = current_user.articles  
    else  
      @articles = Article.all  
    end  
```

### Only allow logged in users the ability to create, update or delete albums.
In the Album controller.
	`before_action :authenticate_user!, except: [:index,:show]`
	
Now try to update an album. You should not be allowed!
