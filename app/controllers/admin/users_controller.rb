class Admin::UsersController < ApplicationController
  include CanAdmin
  before_action :authenticate_user!
  before_action :can_admin?
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def new
    @user = User.build_with_temp_password
  end

  def create
    @user = User.build_with_temp_password(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: 'User successfully created!'
    else
      render :new
    end
  end

  def update
    if @user.update_info(user_params)
      redirect_to admin_user_path(@user), notice: 'User successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
