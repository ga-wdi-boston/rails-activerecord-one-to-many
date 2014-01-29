artist_one = Artist.create(name: "Nirvana")

artist_one.albums << Album.create(name: "Nevermind")
artist_one.albums << Album.create(name: "In Utereo")
artist_one.albums << Album.create(name: "Unplugged")
artist_one.albums << Album.create(name: "Bleach")
