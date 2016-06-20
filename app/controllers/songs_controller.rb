class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    render json: @songs
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    render json: @song
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    if @song.save
      render json: @song, status: :created, location: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    if @song.update(song_params)
      head :no_content
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy

    head :no_content
  end

  private

    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :length, :rating)
    end
end
