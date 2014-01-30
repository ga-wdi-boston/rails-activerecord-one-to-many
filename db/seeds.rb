# artist_one = Artist.create(name: "Nirvana")

# nevermind = artist_one.albums << Album.create(name: "Nevermind")
# artist_one.albums << Album.create(name: "In Utereo")
# artist_one.albums << Album.create(name: "Unplugged")
# artist_one.albums << Album.create(name: "Bleach")

# nevermind.songs << Song.create(name: "Smells like Teen Spirit")
# nevermind.songs << Song.create(name: "In Bloom")
# nevermind.songs << Song.create(name: "Lithium")

king = Author.create(name: "Stephen King")
austen = Author.create(name: "Jane Austen")
lovecraft = Author.create(name: "H.P. Lovecraft")

it_book = Book.create(name: "It")
cujo = Book.create(name: "Cujo")
pet = Book.create(name: "Pet Semetary")

pride = Book.create(name: "Pride and Prejudice")
sense = Book.create(name: "Sense and Sensibility")
north = Book.create(name: "Northanger Abby")

fifty_shades_of_wtf = Book.create(name: "50 Shades of Pets and Prejudice. Chithlu")
fifty_shades_of_wtf.authors << king << austen << lovecraft

king.books << it_book << cujo << pet
austen.books << pride << sense << north
