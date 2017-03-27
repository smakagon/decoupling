class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = repo.all
  end

  def new
    @user = repo.new_entity
  end

  def create
    success = ->(user) { redirect_to user_path(user), notice: 'User has been created' }
    error = lambda do |user|
      @user = user
      render :new
    end

    UseCase::User::SignUp.call(user_params, success: success, failure: error)
  end

  def edit; end

  def update
    success = ->(user) { redirect_to user_path(user), notice: 'User has been updated' }
    error = lambda do |user|
      @user = user
      render :edit
    end

    UseCase::User::UpdateProfile.call(@user, user_params, success: success, failure: error)
  end

  def show; end

  def destroy
    success = -> { redirect_to users_path, notice: 'User has been removed' }
    error = -> { redirect_to users_path, alert: 'Couldn\'t remove user' }

    UseCase::User::DeleteProfile.call(@user, success: success, failure: error)
  end

  private

  def set_user
    @user = repo.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password)
  end

  def repo
    @repo ||= UserRepository.new
  end
end
