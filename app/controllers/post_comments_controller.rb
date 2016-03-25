class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:name, :body))

    redirect_to post_path(@post)


  end

  def edit

    @post = Post.find( params[:post_id] )
    @comment = @post.comments.find( params[:id] )

  end

  def update
    @post = Post.find(params[:post_id] )
    @comment = @post.comments.find( params[:id] )

    if @comment.update( comment_params )
      redirect_to post_url( @post )
    else
      render :action => :edit
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
