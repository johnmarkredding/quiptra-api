class Api::V1::UsersController < ApplicationController
	before_action :verify_token, except: [:sign_up, :login, :create]

	def index
		render self.blueprint(User.all)
	end

	def create
		user = self.new_user
		if !!user
			render json: self.blueprint(user)
		else
			render :not_acceptable
		end
	end

	def show
		user = User.find(params[:id])
		if !!user
			if user.id == decoded_token["id"]
				render json: self.blueprint(user)
			else
				render json: {message: "Not allowed!!"}
			end
		else
			render :not_found
		end
	end

	def current
		user = User.find(decoded_token["id"])
		if !!user
			render json: self.blueprint(user)
		else
			render json: {message: "Not Found!!"}
		end
	end

	def sign_up
		if !!self.new_user
			self.login
		else
			render :not_acceptable
		end
	end

	def login
		user = User.find_by(username: params[:username])
		if !!user
			if !!user.authenticate(params[:password])
				render json: {user: self.blueprint(user), token: new_token(user.id)}
			else
				render json: {message: "Invalid Password"}
			end
		else
			render json: {message: "Invalid Username"}
		end
	end

	def new_user
		user = User.new(user_params)
		if !!user.save
			user
		else
			nil
		end
	end

	def blueprint(obj)
		UserBlueprint.render_as_hash(obj)
	end

	private

	def user_params
		params.permit(:username, :name, :password)
	end
end
