class UsersController < ApplicationController

  def index
    if params[:keyword]
      @users = User.where(["first_name like?", "%#{params[:keyword]}%" ])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def event_params
    params.require(:user).permit(:id  )
  end
end
