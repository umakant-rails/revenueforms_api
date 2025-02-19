class KhasraBattanksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  before_action :set_khasra_battank, only: %i[ show edit update destroy ]

  # GET /khasra_battanks or /khasra_battanks.json
  def index
    @khasra_battanks = KhasraBattank.all
  end

  # GET /khasra_battanks/1 or /khasra_battanks/1.json
  def show
  end

  # GET /khasra_battanks/new
  def get_khasra_batank_data
    set_required_data

    if @hissedars.blank? || @land_owners.blank?
      render json: { error: ["इस बंटवारे में मूल भूस्वामी अथवा सह-भागीदार दर्ज नहीं किये है, कृपया इनको दर्ज करे |"] }, status: :unprocessable_entity
    elsif @khasras.blank?
      render json: { error: ["इस बंटवारे में अभी तक खसरा नंबर दर्ज नहीं किये है, कृपया इनको दर्ज करे |"] }, status: :unprocessable_entity
    else
      render json: {
        hissedars: @hissedars,
        land_owners: @land_owners,
        khasras: @khasras,
        new_khasra_battanks: @new_khasra_battanks,
        # battank_created_khasra: @new_khasra_battanks.pluck(:khasra_id).uniq,
        hissedar_battanks: @hissedar_battanks
      }
    end
  end

  # POST /khasra_battanks or /khasra_battanks.json
  def create
    permitted_params = params.permit(khasra_battank: [:khasra_id, :village_id, :new_khasra, :rakba]).fetch(:khasra_battank)
    battanks = @request.khasra_battanks.create(permitted_params)

    if battanks
      set_required_data
      render json: { 
        khasra_battanks: battanks, 
        new_khasra_battanks: @new_khasra_battanks,
        battank_created_khasra: @new_khasra_battanks.pluck(:khasra_id).uniq, 
        message: 'New Battank created successfully.'
      }
    else
      render json: { request: battanks.errors, error: battanks.errors.full_messages }
    end
  end

  def allote_khasra_to_hissedar
    group_id = Time.now.to_i
    hissedars = params[:hissedars].map{|h| h.to_i}
    participant_ids = hissedars.sort.join(",") rescue nil
    participant_khasra = @request.khasra_battanks.where(participant_ids: hissedars.sort.join(","))[0] rescue nil

    params_to_update = {
      participant_ids: participant_ids, 
      group_id: (participant_khasra ? participant_khasra.group_id : group_id)
    }


    @khasra_battanks = @request.khasra_battanks.where(id: params[:khasras])
    if @khasra_battanks.update_all(params_to_update)
      set_required_data
      render json: {
        hissedar_battanks:@hissedar_battanks, 
        new_khasra_battanks: @new_khasra_battanks,
        mesasge: 'Khasra added with participants successfully.'
      }
    end
  end

  def revoke_khasra_of_hissedar
    if KhasraBattank.where(participant_ids: params[:participant_ids]).update_all({participant_ids: '', group_id: nil})
      set_required_data
      render json: {
        hissedar_battanks:@hissedar_battanks,
        new_khasra_battanks: @new_khasra_battanks,
        mesasge: 'Khasra deleted with participants successfully.'
      }
    end
  end

  def destroy
    khasra = KhasraBattank.find(params[:id]).khasra;
    if khasra.khasra_battanks.destroy_all
      @khasras = @request.khasras rescue nil
      @new_khasra_battanks = @request.khasra_battanks.where("group_id is null").order("new_khasra ASC")
      hissedar_battanks = @request.get_hissedar_battanks

      render json: {
        # hissedars: @hissedars,
        # land_owners: @land_owners,
        khasras: @khasras,
        new_khasra_battanks: @new_khasra_battanks,
        battank_created_khasra: @new_khasra_battanks.pluck(:khasra_id).uniq,
        hissedar_battanks: hissedar_battanks,
        message: 'Khasra Battank deleted successfully.'
      }
    end
  end

  private 
    def set_required_data
      @hissedars = @request.participants.hissedar rescue nil
      @land_owners = @request.participants.land_owner rescue nil
      @khasras = @request.khasras rescue nil
      @khasras = @khasras.map{|k| k.attributes.merge({village: k.village})}
      @new_khasra_battanks = @request.khasra_battanks.where("group_id is null") rescue nil
      @hissedar_battanks = @request.get_hissedar_battanks
    end

    def get_hissedar_battanks1
      @new_khasra_battanks = @request.khasra_battanks.where("group_id is null").order("new_khasra asc") rescue nil
      @hissedar_battanks = @request.khasra_battanks.where("group_id is not null").order("group_id ASC") #.pluck(:participant_ids).uniq
      group_id_count = @hissedar_battanks.group("group_id").count
      participant_ids = ''
      participant_names = ''

      @hissedar_battanks = @hissedar_battanks.map.with_index do |hissedar, index| 
        if(participant_ids != hissedar.participant_ids)
          participant_ids = hissedar.participant_ids
          participants = Participant.where("id in (?)", participant_ids.split(","))
          participants = participants.map{ |p| "#{p.name} #{p.relation} #{p.gaurdian}" }
          participant_names = participants.join(", ")
        end
        hissedar.attributes.merge({
          village_name: hissedar.village,
          village_code: hissedar.village.village_code,
          hissedars: participant_names, 
          khasra_count:group_id_count[hissedar.group_id]
        })
      end
    end

    def set_request
      @request = Request.find(params[:request_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_khasra_battank
      @khasra_battank = KhasraBattank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def khasra_battank_params
      params.fetch(:khasra_battank).permit(:khasra_id, :new_khasra, :rakba, :request_id, :participant_ids, :group_id)
    end
end
