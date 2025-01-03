class KhasrasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  before_action :set_khasra, only: %i[ show edit update destroy ]

  def get_khasra_data
    @distrits = District.all.order("name_eng ASC")
    @tehsils = @request.village.district.tehsils
    @villages = @request.village.tehsil.villages.order("village_eng ASC")
    @khasras = @request.khasras

    @request = @request.attributes.merge({
      district_id: @request.village.district_id,
      tehsil_id: @request.village.tehsil_id,
    })
    
    @khasras = @khasras.map do | khasra |
      khasra.attributes.merge({village: khasra.village.village})
    end

    render json: {
      request: @request,
      districts: @distrits,
      tehsils: @tehsils,
      villages: @villages,
      khasras: @khasras
    }
  end

  def create
    @khasra = @request.khasras.new(khasra_params)
    kh =  @request.khasras.where(khasra: params[:khasra][:khasra])

    if kh.blank? && params[:khasra][:khasra].present?
      if @khasra.save!
        @khasras = @request.khasras
        @khasras = @khasras.map do | khasra |
          khasra.attributes.merge({village: khasra.village.village})
        end

        render json: {
          khasras: @khasras
        }
      else
        render json: { khasra: @khasra.errors, error: @khasra.errors.full_messages }
      end
    else
      render json: { error: ["This khasra is already exists."] }, status: :unprocessable_entity
    end
  end

  def update
    if @khasra.update(khasra_params)
      @khasra = @khasra.attributes.merge({village: @khasra.village.village})
      render json: {
        khasra: @khasra
      }
    end
  end

  def destroy
    if @khasra.destroy
      @khasras = @request.khasras
      @khasras = @khasras.map do | khasra |
        khasra.attributes.merge({village: khasra.village.village})
      end

      render json: {
        khasras: @khasras
      }
    end
  end

  private 

  def set_request
    @request = Request.find(params[:request_id])
  end

  def set_khasra
    @khasra = Khasra.find(params[:id])
  end

  def khasra_params
    params.fetch(:khasra).permit(:khasra, :rakba, :sold_rakba, :unit, :request_id, :village_id)
  end
end
