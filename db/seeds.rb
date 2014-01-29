artist_one = Artist.create(name: "Nirvana")

nevermind = artist_one.albums << Album.create(name: "Nevermind")
artist_one.albums << Album.create(name: "In Utereo")
artist_one.albums << Album.create(name: "Unplugged")
artist_one.albums << Album.create(name: "Bleach")

nevermind.songs << Song.create(name: "Smells like Teen Spirit")
nevermind.songs << Song.create(name: "In Bloom")
nevermind.songs << Song.create(name: "Lithium")
