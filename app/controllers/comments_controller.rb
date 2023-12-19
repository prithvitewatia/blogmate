class CommentsController < ApplicationController

  before_action :set_blog_post, only: [:create, :destroy]
  def create
    @comment = @blog_post.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to blog_post_path(@blog_post)
  end

  def destroy
    @comment = @blog_post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to blog_post_path(@blog_post), status: :see_other, notice: 'Deleted your comment'
    else
      redirect_to blog_post_path(@blog_post), status: :unauthorized, alert: 'You are not authorized'
    end
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
