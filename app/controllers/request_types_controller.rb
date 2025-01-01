class RequestTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @request_types = RequestType.all;
    render json: {
      request_types: @request_types
    }
  end

end
