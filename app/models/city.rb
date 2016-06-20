class City < ActiveRecord::Base
  has_many :people, foreign_key: :home_town_id
end
