class ReviewsController < ApplicationController
  # Execute this method before each action is executed
  before_action :set_movie

  # GET /movies/:movie_id/reviews
  def index
    # all the movies
    @reviews = @movie.reviews
    render json: @reviews
  end

  # GET /movies/:movie_id/review/:id
  def show
    @review = @movie.reviews.find(params[:id])
    render json: @review
  end

  # POST /movies/:movie_id/reviews
  def create
    @review = @movie.reviews.build(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end

  end

  # DELETE /movies/:movie_id/reviews/:id
  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    head :no_content
  end

  private

  # find the movie for the review/s
  def set_movie
    # create an instance variable that can be accessed in
    # every action.
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit([:name, :comment])
  end
end
