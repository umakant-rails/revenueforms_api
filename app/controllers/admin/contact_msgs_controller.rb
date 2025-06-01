class Admin::ContactMsgsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_msg, only: %i[ show destroy ]
  # GET /contact_msgs
  def index
    page = params[:page].present? ? params[:page] : 1
    @contact_msgs = ContactMsg.page(page).per(10)
    total_contact_msg = ContactMsg.count

    render json: {
      contact_msgs: @contact_msgs,
      total_contact_msg: total_contact_msg
    }
  end

  # GET /contact_msgs/1
  def show
    render json: {contact_msg: @contact_msg}
  end

  # DELETE /contact_msgs/1
  def destroy
    @contact_msg.destroy
  end

  private

    def set_contact_msg
      @contact_msg = ContactMsg.find(params[:id])
    end

end
