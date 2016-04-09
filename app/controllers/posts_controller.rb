class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  before_action :set_post, :only => [ :show, :edit, :update, :destroy]
  before_filter :authenticate, except: [:index, :show]

  def index

    @groups = Group.all
    @comments = Comment.all
    @posts = Post.page(params[:page]).per(5)

    if params[:post_i] && current_user == Post.find(params[:post_i]).user
      @post = Post.find(params[:post_i])
    else
      @post = Post.new
    end

    # @page = params[:page]

    @com = @comments.last.try(:name)

    if params[:order] # Parameter: {:xxx => "fdsuifd", :order => "sdf"}
      if params[:order] == 'name'
        sort_by = params[:order]
      elsif params[:order] == 'created_at'
        sort_by = params[:order]
      elsif params[:order] == "post_count desc"
        sort_by = params[:order]
      end
      @posts = @posts.order(sort_by)
    end

    if params[:group_id]
      @posts = Group.find(params[:group_id]).posts.page(params[:page]).per(5)
    end

  end

  # def new
  #   @post = Post.new
  # end

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
    @post.post_count!

  end

  # def edit
  #   @posts = Post.page(params[:page]).per(5)
  #   if current_user != @post.user
  #     flash[:notice] = "Don't modified another user's post!"
  #     @post = Post.new
  #   end
  #   render :index
  # end

  def update
    if current_user && @post.user == current_user
      @post.update(post_params)

      redirect_to posts_path(:page => params[:post][:page])
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
    params.require(:post).permit(:name, :description, :category_id,:group_ids =>[])

  end

  def authenticate
    redirect_to posts_path unless current_user == @post.user
  end

end
