class CommentsController < ApplicationController

  before_action :set_blog_post, only: [:create, :destroy]
  def create
    @comment = @blog_post.comments.create(comment_params)
    redirect_to blog_post_path(@blog_post)
  end

  def destroy
    @comment = @blog_post.comment.find(params[:id])
    @comment.destroy
    redirect_to blog_post_path(@blog_post), status: :see_other
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
