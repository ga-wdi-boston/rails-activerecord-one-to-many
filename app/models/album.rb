class Album < ActiveRecord::Base
  GENRES = %w{rock rap country jazz ska }

  validates :name, presence: true
  validates :genre, inclusion: { in: GENRES }

  
  has_many :songs, dependent: :destroy
end
