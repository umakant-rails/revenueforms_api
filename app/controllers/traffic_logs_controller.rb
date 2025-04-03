class TrafficLogsController < ApplicationController
  # Log a visit
  def log_visit
    # debugger
    if !params[:page_url].start_with?('http://localhost:3000/admin') && !params[:page_url].start_with?('http://localhost:3000/users')
      today = Date.today
      page_url = params[:page_url]
      ip_address = request.remote_ip
      VisitorLog.create(ip_address: ip_address, page_url: page_url, visit_date: today)
    end

    render json: { status: 'success' }, status: :ok
  end

  def show
    @traffic_logs = TrafficLog.all
    render json: @traffic_logs
  end
  
  private

  def update_traffic_log(today)
    ip_address = request.remote_ip
    traffic_log = TrafficLog.find_or_initialize_by(visit_date: today, ip_address: ip_address)
    traffic_log.visited_page = traffic_log.visited_page.to_i + 1
    traffic_log.save!
  end

end
