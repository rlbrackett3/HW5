class UsersController < ApplicationController

	def index
		@user = User.find(session[:user_id]) if session[:user_id] # a 'current_user' method and helper on the application_controller could set this up app wide
		@users = User.all
		@posts = Post.all # this should really be handled through the posts_controller
	end

	def new
		@user = User.new
	end

	def profile
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = 'New user created.'
			redirect_to user_path @user
		else
			flast[:alert] = 'User not created'
			redirect_to new_user_path
		end
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id]) # this should really be handled through the posts_controller
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(params[:user])
			flash[:notice] = 'User profile edited.'
			redirect_to user_path @user
		else
			flash[:alert] = 'Profile not updated.'
			redirect_to edit_user_path @user
		end
	end
end
