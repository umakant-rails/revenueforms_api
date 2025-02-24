class Admin::UsersController < ApplicationController

  def index
    set_user_data
    render json: { users: @users, total_users: @total_users, page: @page }
  end

  def destroy
    @user = User.find(params[:id])
    if @user.role_id != 1
      @user.destroy
      set_user_data
      render json: {users: @users, total_users: @total_users, page: @page, message: 'Post delete successfully.'  }
    end
  end

  private

    def set_user_data
      @page = params[:page].present? ? params[:page] : 1
      @users = User.where("role_id!=1").order("created_at DESC").page(@page).per(10)
      @total_users = User.all.count
    end

end
