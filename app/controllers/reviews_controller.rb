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
    @reviews = Review.where(post_id: @post)

    if @reviews.blank?
      @raty = 0
    else
      @raty = @reviews.average(:rating).round(2).to_f
    end


    respond_to do |format|
       format.js
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
