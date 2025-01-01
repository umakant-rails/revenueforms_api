class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[ show edit update destroy ]
  
  def index
    @requests = current_user.requests.joins([:participants, :khasras]).order("created_At DESC").uniq
    @requests = @requests.map do | request |
      request.attributes.merge({username: current_user.username, request_type: request.request_type.name})
    end

    render json: {
      requests: @requests
    }
  end

  def show
    @participants = @request.participants && @request.participants.map{|p| p.attributes.merge({participant_type: p.participant_type.name})}
    @khasras = @request.khasras && @request.khasras.map{|k| k.attributes.merge({village: k.village.village})}
    @request = @request.attributes.merge({
      # participants:@participants, 
      # khasras: @khasras, 
      applicant: @request.applicant_name,
      applicant_address: @request.participants.applicant.address
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

  def pending_request
    @requests = current_user.requests.left_joins([:participants, :khasras]).where("participants.request_id is null or khasras.request_id is null").uniq
    @requests = @requests.map do | request |
      request.attributes.merge({username: current_user.username, request_type: request.request_type.name})
    end

    render json: {
      requests: @requests
    }
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:title, :request_type_id, :year, :village_id, :registry_number, :registry_date)
    end

end
