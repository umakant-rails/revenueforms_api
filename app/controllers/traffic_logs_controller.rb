class TrafficLogsController < ApplicationController
  # Log a visit
  def log_visit
    # Get the current date
    today = Date.today

    # Get the page URL from the request body
    page_url = params[:page_url] # This will capture the 'page_url' sent from the frontend

    # Get visitor details: IP address
    ip_address = request.remote_ip

    # Log individual visit in VisitorLog
    VisitorLog.create(ip_address: ip_address, page_url: page_url, visit_date: today)

    # Update daily traffic log
    update_traffic_log(today)

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
