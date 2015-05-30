class ReviewsController < ApplicationController

  # before_aciton is a Rails method that will invoke the method argument
  before_action :set_movie

  def index
    # The params hash is going to have an entry
    # that looks like this.
    # { ... "movie_id" => "2"}
    # When we access http://localhost:3000/movies/2/reviews

    # Notice that the route 
    # GET /movies/:movie_id/reviews
    # determines the name of the key/value pair for the 
    # movie id in the params hash.

    # Retrieve the movie's reviews
    @reviews = @movie.reviews

    # Return the JSON representation of this movie's 
    # reviews
    render json: @reviews
  end

  # GET /movies/:movie_id/review/:id                                            
  def show
    # Find a specific review for a movie
    @review = @movie.reviews.find(params[:id])

    # return a JSON representation of this review
    render json: @review
  end

  # POST /movies/:movie_id/reviews                                         
  def create
    # Use STRONG parameters to make sure users don't do 
    # a SQL injection attack.
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

  def review_params
    params.require(:review).permit(:name, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end