class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = repo.all
  end

  def new
    @user = repo.new_entity
  end

  def create
    @user = repo.new_entity(user_params)
    if repo.save(@user)
      redirect_to user_path(@user), notice: 'User has been created'
    else
      render :new
    end
  end

  def edit; end

  def update
    @user.assign_attributes(user_params)
    if repo.save(@user)
      redirect_to user_path(@user), notice: 'User has been updated'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'User has been removed'
    else
      redirect_to users_path, alert: 'Couldn\'t remove user'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password)
  end

  def repo
    @repo ||= UserRepository.new
  end
end
