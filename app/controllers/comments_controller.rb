class CommentsController < ApplicationController
  before_action :find_user_and_article

  def new
    @comment = @article.comments.new
  end

  def create
    @article.comments << Comment.create!(comment_params)
    redirect_to [@user, @article]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_user_and_article
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
  end
end
