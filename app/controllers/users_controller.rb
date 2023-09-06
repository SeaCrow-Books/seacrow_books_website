class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
  
    def index
      @users = policy_scope(User)
      authorize @users
    end
  
    def show
      authorize @user
    end
  
    def new
      @user = User.new
      authorize @user
    end
  
    def create
      @user = User.new(user_params)
      authorize @user
      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @user
    end
  
    def update
      authorize @user
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @user
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :role, :password, :password_confirmation)
    end
  end
  