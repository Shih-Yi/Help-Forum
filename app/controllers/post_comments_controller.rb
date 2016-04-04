class PostCommentsController < ApplicationController
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
    if current_user && @comment.try(:user) == current_user 
    end

  end

  def update
    @post = Post.find(params[:post_id] )
    @comment = @post.comments.find( params[:id] )

    if current_user && @comment.try(:user) == current_user 
      if @comment.update( comment_params )
        redirect_to post_url( @post )
      else
        render :action => :edit
      end
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
