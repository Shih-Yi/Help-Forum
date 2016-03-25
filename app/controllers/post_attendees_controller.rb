class PostAttendeesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
  end
end
