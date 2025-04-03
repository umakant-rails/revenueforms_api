class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    date_str = params[:date].present? ? params[:date] : Date.today()
    page = params[:page].present? ? params[:page] : 1
    @visitors = VisitorLog.where(visit_date: date_str)
    today_visited_page = @visitors.count
    today_visited_people = @visitors.pluck(:ip_address).uniq.count
    user_by_visited_pages = @visitors.select("ip_address, count(*) as visit_count")
      .group("ip_address").order("visit_count DESC").page(page).per(10)
    
    visited_page_data(page)

    render json: {
      today_visited_page: today_visited_page,
      today_visited_people: today_visited_people,
      user_by_visited_pages: user_by_visited_pages,
      total_visited_page: @total_visited_page,
      visited_pages: @visited_pages,
    }
  end

  def visited_pages
    date_str = params[:date].present? ? params[:date] : Date.today()
    page = params[:page].present? ? params[:page] : 1
    @visitors = VisitorLog.where(visit_date: date_str)
    visited_page_data(page);

    render json: {
      total_visited_page: @total_visited_page,
      visited_pages: @visited_pages,
    }
  end

  private

    def visited_page_data(page)
      @total_visited_page = @visitors.pluck(:page_url).uniq.count
      @visited_pages = @visitors.select("page_url, count(*) as visit_count")
        .group("page_url").order("visit_count DESC").page(page).per(10)
    end
  
end
