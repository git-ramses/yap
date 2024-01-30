# frozen_string_literal: true

# handles User requests
class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(update_params)
      flash[:success] = 'User updated successfully'
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
      end
    else
      redirect_to edit_user_path(@user)
      flash[:danger] = @user.errors.full_messages.join(', ')
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:email, :role, :team)
  end
end
