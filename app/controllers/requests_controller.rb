class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[ show edit update destroy request_detail batwara_detail]
  
  def index
    request_py_page

    render json: {
      requests: @requests,
      total_requests: @total_requests,
      page: @page
    }
  end

  def show
    @participants = @request.participants && @request.participants.map{|p| p.attributes.merge({participant_type: p.participant_type.name})}
    @khasras = @request.khasras && @request.khasras.map{|k| k.attributes.merge({village: k.village})}
    @request = @request.attributes.merge({
      applicant: @request.applicant_name,
      applicant_address: @request.applicant.present? ? @request.applicant.address : 'Not Avaialble',
      village: @request.village
    })

    render json: {request: @request, participants: @participants, khasras: @khasras}
  end

  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      render json: { request: @request, message: "Request was created successfully."}
    else
      render json: { request: @request.errors, error: @request.errors.full_messages }
    end
  end

  def edit
    districts = District.all
    tehsils = @request.village.district.tehsils
    villages = @request.village.tehsil.villages
    request_types = RequestType.all
    render json: {
      request: @request, 
      request_types: request_types, 
      districts:districts, 
      tehsils:tehsils, 
      villages:villages
    }
  end

   def update
      if @request.update(request_params)
        req_status = (@request.participants.length==0 || @request.khasras.length ==0) ? 'pending' : 'complete'
        render json: { request: @request, req_status: req_status, message: "Request was created successfully."}
      else
        render json: { request: @request.errors, error: @request.errors.full_messages }
      end
    end

  def destroy
    if @request.destroy
      @requests = current_user.requests.left_joins([:participants, :khasras]).where("participants.request_id is null or khasras.request_id is null").uniq
      @requests = @requests.map do | request |
        request.attributes.merge({username: current_user.username, request_type: request.request_type.name})
      end

      render json: { requests: @requests, message: 'Request deleted successfully.' }
    end
  end

  def pending_request
    @requests = current_user.requests.left_joins([:participants, :khasras]).where("participants.id is null or khasras.id is null").distinct
    @requests = @requests.map do | request |
      request.attributes.merge({username: current_user.username, request_type: request.request_type.name})
    end

    render json: {
      requests: @requests
    }
  end

  def request_detail
    request_data
    render json: {request: @request, participants: @participants, khasras: @khasras}
  end

  def batwara_detail
    hissedar_battanks = @request.get_hissedar_battanks
    request_data
    
    render json: {
      request: @request, 
      participants: @participants, 
      khasras: @khasras, 
      hissedar_battanks: hissedar_battanks
    }
  end

  private

    def request_py_page
      @page = params[:page].present? ? params[:page] : 1
      # @requests = current_user.requests.joins([:participants, :khasras]).order("created_At DESC").uniq.page(@page).per(10)
      # @total_requests = current_user.requests.joins([:participants, :khasras]).order("created_At DESC").uniq.count #@requests.total_pages
      @requests = current_user.requests.joins([:participants, :khasras]).order("created_At DESC").uniq #
      @total_requests = @requests.count
      @requests = Kaminari.paginate_array(@requests).page(@page).per(10)
      @requests = @requests.map do | request |
        request.attributes.merge({username: current_user.username, request_type: request.request_type.name})
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:title, :request_type_id, :year, :district_id, :teshil_id, :village_id, :registry_number, :registry_date)
    end

    def request_data
      @participants = @request.participants && @request.participants.map{|p| p.attributes.merge({participant_type: p.participant_type.name})}
      @khasras = @request.khasras && @request.khasras.order("village_id ASC").map{|k|
        village = k.village.attributes.merge({tehsil: k.village.tehsil.name}) 
        k.attributes.merge({ village: village });
      }
      
      village = @request.village
      @request = @request.attributes.merge({
        applicant: @request.applicant_name,
        applicant_address: @request.applicant.present? ? @request.applicant.address : 'Not Avaialble',
        village: village,
        circle: village.ri
      })
    end

end
