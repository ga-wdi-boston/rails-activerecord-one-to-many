# Album.delete_all

nevermind = Album.create(name: "Nevermind")
sea_change = Album.create(name: "Sea Change")

nevermind.songs.create(title: "Smells like Teen Spirit")
nevermind.songs.create(title: "In Bloom")
nevermind.songs.create(title: "Lithium")

sea_change.songs.create(title: "Golden Age")
sea_change.songs.create(title: "Lost Cause")
sea_change.songs.create(title: "Lonesome Tears")

