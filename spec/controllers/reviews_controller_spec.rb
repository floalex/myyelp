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
  
  describe "GET new" do
    let(:business) { Fabricate(:business) }
    
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
        
      before do
        session[:user_id] = current_user.id
        get :new, business_id: business.id
      end
      
      it "sets @business" do
        expect(assigns(:business)).to eq(business)
      end
      
      it "sets @review" do
        expect(assigns(:review)).to be_instance_of(Review)
      end
    end
    
    context "with unauthenticated users" do
      let(:business) { Fabricate(:business) }
      
      it "redirects user to the sign in page" do
        get :new, business_id: business.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  
  describe "POST create" do
    let(:business) { Fabricate(:business) }
    
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }

      context "with valid inputs" do
        before do
          set_current_user(current_user)
          post :create, review: Fabricate.attributes_for(:review), business_id: business.id
        end
        
        it "creates a new review" do
          expect(Review.count).to eq(1)
        end
        
        it "creates a review associated with the business" do
          expect(Review.first.business).to eq(business)
        end
        
        it "creates a review associated with the current user" do
          expect(Review.first.user).to eq(current_user)
        end
        
        it "redirects to the business show page" do
          expect(response).to redirect_to business
        end
        
        it "displays the success message" do
          expect(flash[:success]).to eq("You have added a review!")
        end
        
      end
      
      context "with invalid inputs" do
        before do
          set_current_user(current_user)
          post :create, review: {rating: 4}, business_id: business.id
        end
        
        it "doesn't create a new review" do
          expect(Review.count).to eq(0)
        end
        
        it "sets @review" do
          expect(assigns[:review]).to be_instance_of(Review)
        end
        
        it "renders the review new template" do
          expect(response).to render_template(:new)
        end

      end
      
    end
    
    context "with unauthenticated users" do
      it "redirects user to the sign in page" do
        get :new, business_id: business.id
        expect(response).to redirect_to sign_in_path
      end
    end
    
  end
  
end