class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to artists_path
    else
      render :new
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :artist_id)
  end
end
