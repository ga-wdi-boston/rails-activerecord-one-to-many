class AuthorsController < ApplicationController
  def show
  end

  def index
    @authors = Author.all
  end

  def create
  end
end
