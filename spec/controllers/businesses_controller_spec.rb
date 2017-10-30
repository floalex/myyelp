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
    it "sets @business" do
      get :new
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end
  
  describe "POST create" do
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
end