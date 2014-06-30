class SongsController < ApplicationController

  before_action :set_album, only: [:index, :show]

  # GET /albums/:id/songs
  def index
    @songs = @album.songs
  end

  # GET /albums/:album_id/songs/:id
  def show
    @song = Song.find(params[:id])
  end

  private

  def set_album
    @album = Album.find(params[:album_id])  
  end
end