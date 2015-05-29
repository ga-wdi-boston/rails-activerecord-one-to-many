class ReviewsController < ApplicationController
  # Execute this method before each action is executed
  before_action :set_movie

  # GET /movies/:movie_id/reviews
  def index
    # all the movies
    @reviews = @movie.reviews
    render json: @reviews
  end

  private

  # find the movie for the review/s
  def set_movie
    # create an instance variable that can be accessed in
    # every action.
    @movie = Movie.find(params[:movie_id])
  end
end
