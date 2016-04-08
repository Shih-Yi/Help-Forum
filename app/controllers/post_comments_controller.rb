class PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:name, :body))
    @comment.user = current_user
    @comment.save

    redirect_to post_path(@post)


  end

  def edit
    @post = Post.find( params[:post_id] )
    @comment = @post.comments.find( params[:id] )

    if @comment.try(:user) != current_user
      redirect_to root_path
    end
    # if current_user && @comment.try(:user) == current_user
    # else
    #   flash[:message] = "Hello"
    #   redirect_to posts_path
    # end

  end

  def update
    @post = Post.find(params[:post_id] )
    @comment = @post.comments.find( params[:id] )

    if @comment.try(:user) == current_user
      if @comment.update( comment_params )
        redirect_to post_url( @post )
      else
        render :action => :edit
      end
    else
      redirect_to root_path
    end

  end

  def destroy
    @post = Post.find(params[:post_id] )
    @comment = @post.comments.find( params[:id] )
    @comment.destroy

    redirect_to post_url(@post)
  end

  protected

  def comment_params
    params.require(:comment).permit(:name,:body)
  end
end
