class AuthorsController < ApplicationController
  before_action :get_author, only: [:show, :edit, :update, :destroy]

  def show
    @author = Author.find(params[:id])
  end

  def index
    if params[:book_id]
      @book = Book.find(params[:book_id])
      @authors = @book.authors
    else
      @authors = Author.all
    end
  end

  def update
    @author.update(author_params)
    redirect_to @author
  end

  def edit
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    @author.save!
    redirect_to @author
  end

  private

  def get_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, book_ids: [])
  end
end
