class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    page = params[:page].present? ? params[:page] : 1
    requests, total_requests = nil, nil
    if(params[:user_id]).present?
      requests = Request.includes([:participants, :khasras]).where(user_id: params[:user_id]).order("created_At DESC").page(page).per(10)
      total_requests = Request.includes([:participants, :khasras]).where(user_id: params[:user_id]).order("created_At DESC").count
    else
      requests = Request.includes([:participants, :khasras]).order("created_At DESC").page(page).per(10)
      total_requests = Request.includes([:participants, :khasras]).order("created_At DESC").count
    end

     #@requests.total_pages
    requests_tmp = requests.map do | request |
      request.attributes.merge({username: request.user.username, request_type: request.request_type.name})
    end

    users = User.joins(:requests).distinct.select(:id, :username)

    render json: {
      requests: requests_tmp,
      users: users,
      total_requests: total_requests,
      page: page
    }
  end

  def search
    search_text = params[:search_text].strip
    @requests= Request.includes([:participants, :khasras]).where("title LIKE ?", "%#{search_text}%").order("created_At DESC")
    @total_requests = Request.includes([:participants, :khasras]).order("created_At DESC").count #@requests.total_pages
    @requests = @requests.map do | request |
      request.attributes.merge({username: request.user.username, request_type: request.request_type.name})
    end
    @users = User.joins(:requests).distinct.select(:id, :username)

    render json: {
      requests: @requests,
      users: @users,
      total_requests: @total_requests,
    }
  end

end
