class ArtistsController < ApplicationController
  def show
  end

  def index
    @artists = Artist.all
  end

  def create
  end
end
