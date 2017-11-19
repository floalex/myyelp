class ReviewsController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
  def index
    @reviews = Review.all.limit(10)
  end
  
  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
  end
  
  def create
    @business = Business.find(params[:business_id])
    @review = @business.reviews.build(review_params.merge!(user: current_user))
    
    if @review.save
      flash[:success] = "You have added a review!"
      redirect_to @business
    else
      render :new
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end