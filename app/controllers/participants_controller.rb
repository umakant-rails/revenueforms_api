class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  # before_action :set_required_data, only: %i[new edit create update]
  before_action :set_participant, only: %i[ show edit update destroy mark_applicant ]

  def index
    @participants = @request.participants
    @participants = @participants.map do | participant |
      participant.attributes.merge({participant_type: participant.participant_type.name})
    end

    render json: {
      participants: @participants
    }
  end

  def create
    @participant = @request.participants.new(participant_params)

    update_applicant_participant if params[:participant][:is_applicant] == 'true' 
    @participant.save

    @participants = @request.participants
    @participants = @participants.map do | participant |
      participant.attributes.merge({participant_type: participant.participant_type.name})
    end

    render json: {
      participants: @participants
    }
  end

  def update
    update_applicant_participant if params[:participant][:is_applicant] == 'true'
    if @participant.update(participant_params)
      # @participants = @request.participants
      # @participants = @participants.map do | participant |
      #   participant.attributes.merge({participant_type: participant.participant_type.name})
      # end
      @participant.attributes.merge({participant_type: @participant.participant_type.name})

      render json: {
        participant: @participant
      }
    end
  end

  def destroy
    if @participant.destroy
      @participants = @request.participants
      @participants = @participants.map do | participant |
        participant.attributes.merge({participant_type: participant.participant_type.name})
      end
      render json: {
        participants: @participants,
        message: 'Participant deleted successfully.'
      }
    end
  end

  def mark_applicant
    update_applicant_participant
    @participant.update(is_applicant: true)
    @participants = @request.participants
    @participants = @participants.map do | participant |
      participant.attributes.merge({participant_type: participant.participant_type.name})
    end
    
    render json: {
      participants: @participants,
      message: 'Participants marked as applicant successfully.'
    }
  end

  private

    def update_applicant_participant
      participant = @request.participants.where(is_applicant: true) rescue nil
      participant.update(is_applicant: false) if participant.present?
    end

    def remove_params_extra_space
      params[:participant].each{|k, v| params[:participant][k] = v.strip }
    end

    def set_request
      @request = Request.find(params[:request_id])
    end

    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.fetch(:participant).permit(:name, :relation, :gaurdian, :address, :is_dead, :death_date,
        :is_nabalig, :balee, :parent_id, :request_id, :depth, :relation_to_deceased, :is_shareholder,
        :participant_type_id, :total_share_sold, :is_applicant)
    end
end
