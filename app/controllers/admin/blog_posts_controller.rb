class Admin::BlogPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = BlogPost.all.order("created_at DESC").page(page).per(10)
    total_posts = BlogPost.all.count
    @posts  = @posts.map{ |p| p.attributes.merge({blog_subject: p.blog_subject.name})}
    render json: { posts: @posts, total_posts: total_posts }
  end

  def create
    @post = BlogPost.new(post_params)
    if @post.save
      render json: { post: @post, message: 'Post created successfully.' }
    else
      render json: { khasra: @post.errors, error: @post.errors.full_messages }
    end
  end

  def show
    post = BlogPost.find(params[:id])
    render json: {post: post}
  end

  def update
    if @post.update(post_params)
      render json: { post: @post, message: 'Post updated successfully.'  }
    end
  end

  def destroy
    @post.destroy
    render json: { post: @post, message: 'Post delete successfully.'  }
  end

  private
    def set_post
      @post = BlogPost.find(params[:id])
    end

    def post_params
      params.fetch(:blog_post).permit(:blog_subject_id, :title, :content, :image, :video)
    end

end
