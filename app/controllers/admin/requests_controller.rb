class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @page = params[:page].present? ? params[:page] : 1
    @requests = Request.includes([:participants, :khasras]).order("created_At DESC").page(@page).per(10)
    @total_requests = Request.includes([:participants, :khasras]).order("created_At DESC").count #@requests.total_pages
    @requests = @requests.map do | request |
      request.attributes.merge({username: request.user.username, request_type: request.request_type.name})
    end

    render json: {
      requests: @requests,
      total_requests: @total_requests,
      page: @page
    }
  end

end
