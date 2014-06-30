class Song < ActiveRecord::Base
  validates :title, :artist, :duration,  presence: true
  validates :duration, numericality: {greater_than: 60}
  
  # defines getter, setter and some other methods 
  # for the Song model.
  belongs_to :album

end
