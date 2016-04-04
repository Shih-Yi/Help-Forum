class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  private

  def event_params
    params.require(:user).permit(:id  )
  end
end
