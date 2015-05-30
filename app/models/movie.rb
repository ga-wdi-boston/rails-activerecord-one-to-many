class Movie < ActiveRecord::Base

  # create a relationship, one to many relationship,
  # with reviews
  has_many :reviews, dependent: :destroy

end
