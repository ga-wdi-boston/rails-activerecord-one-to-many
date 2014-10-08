class SongsController < ApplicationController
  def create
    @song = Song.create(song_params)
    redirect_to @song.album
  end

  private
  def song_params
    params.require(:song).permit(:title, :album_id)
  end
end
