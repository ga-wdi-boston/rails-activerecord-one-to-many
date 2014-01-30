class ArticlesController < ApplicationController
  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @articles = @user.articles.order(created_at: :desc)
    else
      @articles = Article.order(created_at: :desc)
    end
  end
end
