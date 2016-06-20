class Person < ActiveRecord::Base
  belongs_to :city
  has_many :pets
end
