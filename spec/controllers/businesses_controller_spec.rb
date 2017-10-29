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
end