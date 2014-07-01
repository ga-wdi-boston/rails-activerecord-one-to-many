# Many to Many Relationships

### Objectives
* Create many to many relationship.

* Add a User - Album Many to Many relationship
 `r g model ManagedAlbums user:belongs_to album:belongs_to role`
 
 Take a look at the migration and model generated.
 
* In the User model, user.rb add.  

```
 has_many :managed_albums, class_name: 'ManagedAlbums' 
  has_many :albums, through: :managed_albums
```

I've added the role so that we can in the future authorize action based on the role or admin, creative director and artist. 


* Add Seed data.

```
User.delete_all
...

jill =  User.create!(email: 'jill@example.com', password: 'password', role: 'admin')
fred =  User.create!(email: 'fred@example.com', password: 'password', role: 'creative director')
mort =  User.create!(email: 'mort@example.com', password: 'password', role: 'artist')
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
