class SongsController < ApplicationController

  # GET /songs?album_id=:id
  def index
    @album = Album.find(params[:album_id])  
    @songs = @album.songs
  end


  def show
    @song = Song.find(params[:id])
  end
end