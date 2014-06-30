class Song < ActiveRecord::Base
  # defines getter, setter and some other methods 
  # for the Song model.
  belongs_to :album
  # # getter
  # def album
  #   @album
  # end

  # # setter
  # def album=(album)
  #   @album = album
  # end
end
