class ReviewsController < ApplicationController
  before_action :set_post

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new( :rating => params[:rating] )
    @review.post = @post
    @review.save

    respond_to do |format|
      format.json{
        render :json => {:rating => @review.rating}
      }
    end

  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
