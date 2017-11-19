require 'rails_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  
  describe "POST create" do
    
    context "with valid information" do
  
      before do
        post :create, user: Fabricate.attributes_for(:user) 
      end
      
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end
    
    context "with invalid information" do
      
      before do
        post :create, user: { password: "password" } 
      end
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      
      it "redirects to the :new template" do
        expect(response).to render_template(:new)
      end
      
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
      
    end
    
  end
  
  describe "GET show" do
    let(:user) { Fabricate(:user) }
    
    it "sets @user to be the user is being viewed" do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
  
end