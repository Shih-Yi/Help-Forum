class UsersController < ApplicationController

  def index
    if params[:keyword] == nil
      @users = current_user.friends
    else params[:keyword]
      @users = User.where(["email like?", "%#{params[:keyword]}%"])
    end



    # @users = User.all unless @users.present?
  end

  def show
    @user = User.find(params[:id])

    @user_commented_posts = Post.where(id: current_user.comments.pluck(:post_id).uniq)
  end

  private

  def event_params
    params.require(:user).permit(:id  )
  end
end
