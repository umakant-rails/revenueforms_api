class Public::BlogPostsController < ApplicationController

  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = BlogPost.all.order("created_at DESC").page(page).per(10)
    total_posts = BlogPost.all.count
    @posts  = @posts.map{ |p| p.attributes.merge({blog_subject: p.blog_subject.name})}
    subjects = BlogSubject.all
    render json: { posts: @posts, total_posts: total_posts, subjects: subjects }
  end

  def show
    post = BlogPost.find_by_title(params[:id])
    post = post.attributes.merge({blog_subject: post.blog_subject.name})
    render json: {post: post}
  end

end
