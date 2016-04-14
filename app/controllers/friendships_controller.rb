class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice]="added friend."
      redirect_to users_path
    else
      flash[:error] = "unable to add friend"
      redirect_to users_path
    end
  end

  def show

    @friendship = current_user.friendships.find(params[:id])
  end

  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
    @friendship.destroy

    flash[:notice] = "Removed friendship."
    redirect_to users_path
  end
end
