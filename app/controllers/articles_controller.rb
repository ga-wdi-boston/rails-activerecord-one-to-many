class ArticlesController < ApplicationController
  before_action :find_user, only: [:new, :create, :edit, :update]
  before_action :find_article, only: [:show, :edit, :update]

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @articles = @user.articles.order(created_at: :desc)
    else
      @articles = Article.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @article = @user.articles.new
  end

  def create
    article = Article.create!(article_params)
    @user.articles << article
    redirect_to [@user, article]
  end

  def edit
  end

  def update
    @article.update!(article_params)
    redirect_to [@user, @article]
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
