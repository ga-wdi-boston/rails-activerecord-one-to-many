class SongsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # Get run before the actions
  before_action :set_album

  # GET /albums/:album_id/songs
  def index
    @songs = @album.songs
  end

  # GET /songs/:id
  def show
    # ONLY look in this album for songs with 
    # the id in the params.
    @song = @album.songs.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
  end 

  def edit
  end

  def update
  end

  def destroy
  end
  private

  def set_album
    @album = Album.find(params[:album_id])
  end
  
end