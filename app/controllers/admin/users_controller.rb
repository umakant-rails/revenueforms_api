class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    set_user_data
    render json: { users: @users, total_users: @total_users, page: @page }
  end

  def confirm_user
    @user = User.find(params[:id])
    if @user.update(confirmed_at: Time.now)
      set_user_data
      render json: {users: @users, total_users: @total_users, page: @page, message: 'Post confirm successfully.'  }
    end
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
      @page = params[:page].present? ? params[:page].to_i : 1
      @userss = User.where("role_id!=1")
        .select("id, email, username, mobile, is_order_display, created_at, updated_at, confirmed_at")
        .order("created_at DESC").page(@page).per(10)
      @users = @userss.map { |u| u.attributes.merge({confirmed_at: u.confirmed_at})}
      @total_users = User.all.count
    end

end
