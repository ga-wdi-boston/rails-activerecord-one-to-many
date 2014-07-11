class SongSearchesController < ApplicationController

  def new
    @song_search = SongSearch.new
  end

  def create
    @songs = SongSearch.search(params[:song_search])

    @title_msg = @songs.empty? ? "No songs with ": "Songs with "
    @title_msg += params[:song_search][:title]
    
    render :index
  end
end
