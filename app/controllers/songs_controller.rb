class SongsController < ApplicationController

  # GET /songs
  def index
    @songs = Song.all 
  end

  # GET /songs/:id
  def show
    @song = Song.find(params[:id])
  end

end