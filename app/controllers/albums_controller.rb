class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all

    render json: @albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    render json: @album
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    if @album.save
      render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      head :no_content
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy

    head :no_content
  end

  private

    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :artist)
    end
end
