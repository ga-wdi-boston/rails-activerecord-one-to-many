class Author < ActiveRecord::Base
  # HABTM
  has_and_belongs_to_many :books
end
