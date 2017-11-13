require 'rails_helper'

describe ReviewsController do
  describe "GET recent" do
    
    context "with 0 reviews" do
      it "returns an empty array when there is no reviews" do
        get :index
        expect(assigns[:reviews]).to eq([])
      end
    end
    
    context "with less than 10 reviews" do
      it "sets @reviews to the most recent ones in reverse chronogical order" do
        reviews = []
        
        9.times do
          reviews << Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
        end
        
        get :index
        
        expect(assigns[:reviews]).to eq(reviews.reverse)
      end
    end
    
    context "with more than 10 reviews" do
       it "sets @reviews to the 10 most recent ones in reverse chronogical order" do
        reviews = []
        
        12.times do
          reviews << Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
        end
        
        get :index
        
        expect(assigns[:reviews]).to eq(reviews.reverse[0...10])
      end
    end
  end
end