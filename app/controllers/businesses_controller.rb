class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
  def index
    @businesses = Business.all
  end
  
  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews
  end
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = "You have added a new business!"
      redirect_to home_path
    else
      render :new
    end
  end
  
  private 
  
  def business_params
    params.require(:business).permit(:name, :address, :city, :state, :zipcode, :phone)
  end
end