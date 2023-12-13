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
        @blog_post = BlogPost.new(blog_post_params)

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

        if @blog_post.update(blog_post_params)
          redirect_to @blog_post
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post = blog_post_by_id
        @blog_post.destroy

        redirect_to root_path, status: :see_other
    end

    private

    def blog_post_by_id
        @blog_post = BlogPost.find(params[:id])
    end

    def blog_post_params
        params.require(:blog_post).permit(:title, :body, :status)
    end
end
