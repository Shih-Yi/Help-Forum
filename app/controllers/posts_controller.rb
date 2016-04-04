class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_post, :only => [ :show, :edit, :update, :destroy]

  def index
    @post = Post.new
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @posts = Post.page(params[:page]).per(5)
    @posts = @posts.order(sort_by)
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :action => :new
    end
    flash[:notice] = "event was successfully created"
  end

  def show

  end

  def edit
    @posts = Post.page(params[:page]).per(5)
    render :index
  end

  def update
    if current_user && @post.user == current_user 
      @post.update(post_params)
      redirect_to post_path(@post)
    end
    flash[:notice] = "event was successfully updated"
  end

  def destroy
    @post.destroy

    redirect_to posts_path(:page=> params[:page])
    flash[:alert] = "event was successfully deleted"
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :category_id,:group_ids => [])

  end

end
