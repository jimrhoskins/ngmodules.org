class BlogPostsController < ApplicationController
  before_filter :get_post, except: [:index, :new, :create]
  authorize_resource

  def index
    @blog_posts = BlogPost.published.order('published_at DESC')

  end

  def new
    @blog_post = BlogPost.new
  end

  def create 
    @blog_post = current_user.blog_posts.build permitted_params.blog_post
    if @blog_post.save
      redirect_to @blog_post
    else
      render action: :new
    end
  end


  def update
    if @blog_post.update_attributes(permitted_params.blog_post)
      redirect_to @blog_post
    else
      render action: :edit
    end
  end

  def edit
  end

  def show
  end


private 

  def get_post
    @blog_post = BlogPost.find_by_permalink!(params[:id])
  end
end
