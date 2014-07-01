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

  # GET /albums/:album_id/songs/new
  def new
    @song = Song.new
  end

  # POST /albums/1/songs
  def create
    @song = @album.songs.new(song_params)

    if @song.save
      redirect_to album_songs_path(@album), notice: "Song #{@song.title} created in #{@album.name}"
    else
      render :new
    end
  end 

  def edit
    @song = @album.songs.find(params[:id])
  end

  def update
    @song = @album.songs.find(params[:id])
    if @song.update(song_params)
      redirect_to album_songs_path(@album, @song), notice: "You have updated the #{@song.title}"
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to album_songs_path(@album), alert: 'Song deleted'
  end
  
  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def song_params
    params.require(:song).permit([:title, :artist, :duration, :price, :album_id ])
  end
                                 
end
