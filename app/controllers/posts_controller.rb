class PostsController < ApplicationController

  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!, :except => [:index]
  before_action :set_post, :only => [ :show, :edit, :update, :destroy]
  # before_filter :authenticate, except: [:index, :show]

  def index

    @groups = Group.all
    @comments = Comment.all
    @posts = Post.page(params[:page]).per(5)

    # if params[:post_i] && current_user == Post.find(params[:post_i]).user
    #   @post = Post.find(params[:post_i])
    # else
      @post = Post.new
    # end

    @posts = Post.order(sort_column+" "+sort_direction).page(params[:page]).per(5)


    if params[:order] # Parameter: {:xxx => "fdsuifd", :order => "sdf"}
      if params[:order] == 'name'
        sort_by = params[:order]
      elsif params[:order] == 'created_at'
        sort_by = params[:order]
      elsif params[:order] == 'post_count'
        sort_by = params[:order]
      elsif params[:order] == 'comment_number'
        sort_by = params[:order]
      end
      @posts = @posts.order(sort_by)
    end

    if params[:group_id]
      @posts = Group.find(params[:group_id]).posts.page(params[:page]).per(5)
    end

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
    if cookies.signed["view-topic-#{@post.id}-user-#{current_user.id}"].nil?
      @post.post_count!
      cookies.signed["view-topic-#{@post.id}-user-#{current_user.id}"]  = Post.find("#{@post.id}")

    end

    @reviews = Review.where(post_id: @post)
    if @reviews.blank?
      @raty = 0
    else
      @raty = @reviews.average(:rating).round(2)
    end
  end

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

  # def authenticate
  #   redirect_to posts_path unless current_user == @post.user
  # end

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
