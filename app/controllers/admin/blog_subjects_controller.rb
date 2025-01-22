class Admin::BlogSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: %i[ show edit update destroy ]

  def index
    if params[:page] == 'undefined'
      @subjects = BlogSubject.all.order("created_at DESC")
    else
      page = params[:page].present? ? params[:page] : 1
      @subjects = BlogSubject.all.order("created_at DESC").page(page).per(10)
      total_subjects = BlogSubject.all.count
    end
    render json: { subjects: @subjects, total_subjects: total_subjects }
  end

  def create
    @subject = BlogSubject.new(subject_params)
    
    if @subject.save
      render json: { subject: @subject, message: 'Subject created successfully.' }
    else
      render json: { khasra: @post.errors, error: @post.errors.full_messages }
    end
  end

  def show
    page = params[:page].present? ? params[:page] : 1
    posts = @subject.blog_posts.page(page).per(10)
    total_posts = @subject.blog_posts.all.count
    render json: { subject: @subject, posts: posts, total_posts: total_posts}
  end

  def update
    if @subject.update(subject_params)
      render json: { subject: @subject, message: 'Subject updated successfully.'  }
    end
  end

  def destroy
    if @subject.destroy
      @subjects = BlogSubject.all.order("created_at DESC")
      render json: {
        subjects: @subjects,
        message: 'Subject deleted successfully.'
      }
    end
  end

  def get_subjects
    subjects = BlogSubject.all.order("created_at DESC")
    render json: { subjects: subjects}
  end

  private
    def set_subject
      @subject = BlogSubject.find(params[:id])
    end

    def subject_params
      params.fetch(:blog_subject).permit(:name, :name_eng)
    end
end

