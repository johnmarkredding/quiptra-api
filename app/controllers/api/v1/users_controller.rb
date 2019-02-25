class Api::V1::UsersController < ApplicationController
	def index
		render json: User.all
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user
		else
			render :not_acceptable
		end
	end

	def show
		user = User.find(params[:id])
		if !!user
			if user.id == decoded_token["id"]
				render json: user
			else
				render json: {message: "Not allowed!!"}
			end
		else
			render :not_found
		end
	end

	def sign_up
	end

	def login
		user = User.find_by(username: params[:username])
		if !!user
			if !!user.authenticate(params[:password])
				render json: {user: user, token: new_token(user.id)}
			else
				render json: {message: "Invalid Password"}
			end
		else
			render json: {message: "Invalid Username"}
		end
	end

	private
	def user_params
		params.permit(:username, :name, :password)
	end
end
