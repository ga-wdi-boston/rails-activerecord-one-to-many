class ArticlesController < ApplicationController
  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @articles = @user.articles.order(created_at: :desc)
    else
      @articles = Article.order(created_at: :desc)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @article = @user.articles.new
  end

  def create
    user = User.find(params[:user_id])
    article = Article.create!(article_params)
    user.articles << article
    redirect_to [user, article]
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
