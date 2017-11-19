require 'rails_helper'

describe BusinessesController do
  
  describe "GET index" do
    it "sets @businesses" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business, created_at: 1.day.ago)
      get :index
      expect(assigns[:businesses]).to eq([business1, business2])
    end
  end
  
  describe "GET new" do
    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }
     
      it "sets @business" do
        get :new
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end
    
    context "with unauthenticated users" do
      it "does not set @business" do
        get :new
        expect(assigns(:business)).to be(nil)
      end
      
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to sign_in_path
      end
    end
    
  end
  
  describe "POST create" do
    
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      
      before do
        session[:user_id] = current_user.id
      end
      
      context "with valid input" do
        before do
          post :create, business: Fabricate.attributes_for(:business)
        end
        
        it "creates a new business" do
          expect(Business.count).to eq(1)
        end
        
        it "redirects to the business index page" do
          expect(response).to redirect_to home_path
        end
        
      end
      
      context "with invalid input" do
        before do
          post :create, business: { zipcode: "11111" }
        end
        
        it "doesn't create a new business" do
          expect(Business.count).to eq(0)
        end
        
        it "renders the new template" do
          expect(response).to render_template :new
        end
        
        it "sets @business" do
          expect(assigns(:business)).to be_instance_of(Business)
        end
      end
    end
    
    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        post :create, business: Fabricate.attributes_for(:business)
        expect(response).to redirect_to sign_in_path
      end
    end
    
  end
  
  describe "GET show" do
    let(:business) { Fabricate(:business) }
    
    it "sets @business" do
      get :show, id: business.id
      expect(assigns(:business)).to eq(business)
    end
    
    it "sets @reviews associated with the business" do
      review1 = Fabricate(:review, business: business)
      review2 = Fabricate(:review, business: business)
      get :show, id: business.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end
  
end