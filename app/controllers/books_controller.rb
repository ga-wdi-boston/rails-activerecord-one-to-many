class BooksController < ApplicationController
  before_action :get_book, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    if params[:author_id]
      @author = Author.find(params[:author_id])
      @books = @author.books
    else
      @books = Book.all
    end
  end

  def edit
  end

  def update
    @book.update(book_params)
    redirect_to @book
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save!
    redirect_to @book
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, author_ids: [])
  end
end
