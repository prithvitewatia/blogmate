# Controller for blog posts
class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    def index
        @blog_posts = BlogPost.all.reverse
    end

    def show
        @blog_post = blog_post_by_id
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
        @blog_post = BlogPost.new(blog_post_params.merge(user_id: current_user.id))

        if @blog_post.save
          redirect_to @blog_post
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
        @blog_post = blog_post_by_id
    end

    def update
        @blog_post = blog_post_by_id

        if @blog_post.user == current_user and @blog_post.update(blog_post_params)
          logger.info "Blog Post updated successfully"
          redirect_to @blog_post, notice: 'Blog updated successfully'
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post = blog_post_by_id
        if @blog_post.user == current_user
            @blog_post.destroy
            logger.info "Blog post deleted successfully"
            redirect_to root_path, status: :see_other, notice: 'Blog Deleted'
        else
            redirect_to root_path, status: :unauthorized, alert: 'You are not authorized'
        end
    end

    private

    def blog_post_by_id
        @blog_post = BlogPost.find(params[:id])
    end

    def blog_post_params
        params.require(:blog_post).permit(:title, :body, :status)
    end
end
