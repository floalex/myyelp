class ReviewsController < ApplicationController
  def index
    @reviews = Review.all.limit(10)
  end
end