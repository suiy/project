class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new (params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else 
      render 'new'
    end
  end

  def edit
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to '/signin', notice: "Please sign in"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_back_or(root_path) unless current_user?(@user)
    end

end
