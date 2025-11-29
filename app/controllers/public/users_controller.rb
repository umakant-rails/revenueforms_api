class Public::UsersController < ApplicationController

	def index
		per_page = 10
		page = params[:page].blank? ? 1 : params[:page].to_i
		search_text = params[:search_text]
		users, total_users = nil, 0

		if search_text.blank?
			users_scope = User.where("role_id != 1")
			users = users_scope.select("email, username, mobile, confirmed_at")
				.page(page)
				.per(per_page)
			total_users= users_scope.count
		else
			users_scope = User.where("role_id != 1 and (email like ? or username like ?) ", "%#{search_text}%", "%#{search_text}%")
			users = users_scope.select("email, username, mobile, confirmed_at")
				.page(page)
				.per(per_page)

			total_users = users_scope.count
		end

		render json: {
			page: page,
      users: users,
      total_users: total_users
    }
	end

end
