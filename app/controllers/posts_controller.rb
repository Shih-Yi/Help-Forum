class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_post, :only => [ :show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @posts = Post.page(params[:page]).per(5)
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
  end

  def show

  end

  def edit

  end

  def update
    if current_user && @post.user == current_user 
      @post.update(post_params)
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path( params[:page])
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :category_id)

  end

end
