class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    date_str = params[:date].present? ? params[:date] : Date.today()
    page = params[:page].present? ? params[:page] : 1
    @visitors = VisitorLog.where(visit_date: date_str)
    visited_user_data(page)
    visited_page_data(page)

    render json: {
      total_number_visited_pages: @total_number_visited_pages,
      visited_people_details: @visited_people_details,
      total_visited_people: @total_visited_people,
      visited_page_details: @visited_page_details,
      total_visited_pages: @total_visited_pages
    }
  end
  
  def visited_users
    date_str = params[:date].present? ? params[:date] : Date.today()
    page = params[:page].present? ? params[:page] : 1
    @visitors = VisitorLog.where(visit_date: date_str)
    visited_user_data(page);

    render json: {
      visited_people_details: @visited_people_details,
      total_visited_people: @total_visited_people,
    }
  end

  def visited_pages
    date_str = params[:date].present? ? params[:date] : Date.today()
    page = params[:page].present? ? params[:page] : 1
    @visitors = VisitorLog.where(visit_date: date_str)
    visited_page_data(page);

    render json: {
      visited_page_details: @visited_page_details,
      total_visited_pages: @total_visited_pages,
    }
  end

  private

    def visited_user_data(page)
      @total_visited_people = @visitors.pluck(:ip_address).uniq.count
      @visited_people_details = @visitors.select("ip_address, count(*) as visit_count")
      .group("ip_address").order("visit_count DESC").page(page).per(10)
    end

    def visited_page_data(page)
      @total_number_visited_pages = @visitors.count
      @total_visited_pages = @visitors.pluck(:page_url).uniq.count
      @visited_page_details = @visitors.select("page_url, count(*) as visit_count")
        .group("page_url").order("visit_count DESC").page(page).per(10)
    end
  
end
