class ContactMsgsController < ApplicationController

  # POST /contact_msgs
  def create
    @contact_msg = ContactMsg.new(contact_msg_params)

    if @contact_msg.save
      render json: @contact_msg, status: :created, location: @contact_msg
    else
      render json: @contact_msg.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_msg_params
      params.require(:contact_msg).permit(:name, :email, :subject, :description)
    end
end
