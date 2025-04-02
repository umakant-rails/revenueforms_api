class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    page = params[page].present? ? params[:page] : 1
    visitors = VisitorLog.where(visit_date: Date.today())
    today_visited_page = visitors.count
    today_visited_people = visitors.pluck(:ip_address).uniq.count
    user_by_visited_pages = visitors.select("ip_address, count(*) as visit_count")
      .group("ip_address").order("visit_count DESC").page(page).per(10)

    render json: {
      today_visited_page: today_visited_page,
      today_visited_people: today_visited_people,
      user_by_visited_pages: user_by_visited_pages
    }
  end

end
