class SongsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # Get run before the actions
  before_action :set_album

  # GET /albums/:album_id/songs
  def index
    @songs = @album.songs
  end

  # GET /albums/:album_id/songs/:id
  def show
    # ONLY look in this album for songs with 
    # the id in the params.
    @song = @album.songs.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    # Why don't I have to pass in the id of the Album 
    # that this song belongs to?

    # Because Rails has_many will set the album_id automagically
    # because we are adding the song to specific album.
    @song = @album.songs.new(song_params)

    if @song.save
      redirect_to album_songs_path(@album), notice: "You created a new song"
    else
      render :new
    end
  end 

  def edit
    # Get an existing song from an album
   @song = @album.songs.find(params[:id])
  end

  def update
    # Find the song, by id, in the album
    @song = @album.songs.find(params[:id])

    # update the song 
    if @song.update(song_params)
      # Show all the songs for this album
      redirect_to album_songs_path(@album), notice: "You updated song"
    else
      render :edit
    end
  end

  def destroy
  end
  private

  # Make the params strong
  def song_params
    params.require(:song).permit(:title, :duration, :price, :artist)
  end

  def set_album
    @album = Album.find(params[:album_id])
  end
  
end