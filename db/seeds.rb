Movie.destroy_all

# Create Affliction movie
movie = Movie.create!(name: 'Affliction', rating: 'R', desc: 'Little Dark', length: 123)
# Tom's review of Affliction
movie.reviews.create!(name: 'Tom', comment: 'Dark, somber')

# Create Mad Max movie
movie = Movie.create!(name: 'Mad Max', rating: 'R', desc: 'Fun, action', length: 154)
# Jill's review of Mad Max
movie.reviews.create!(name: 'Jill', comment: 'Great, lotsa action')
# Joe's review of Mad Max
movie.reviews.create!(name: 'Joe', comment: 'Hated, it sucks')

# Create Rushmore movie
movie = Movie.create!(name: 'Rushmore', rating: 'PG-13', desc: 'Quirky humor', length: 105)
movie.reviews.create!(name: 'Terri', comment: 'Funny')
movie.reviews.create!(name: 'Joanne', comment: 'Boring, stupid funny')

puts "Created three Movies"
