class Album < ActiveRecord::Base

  #  defining a class constant named GENRES
  # Album::GENRES to access outside of the class
  GENRES = %w{rock rap country jazz ska}

  validates :name, presence: true
  validates :genre, inclusion: {in: GENRES}

  # dependent: :destroy - Will destroy, or remove, all child objects
  # in memory and in the the DB.
  has_many :songs, dependent: :destroy

end
