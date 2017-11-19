require 'rails_helper'

describe Business do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:phone) }
  it { should have_many(:reviews) }
  
  describe "default scope" do
    it "returns the businesses in the reverse chronical order by created_at" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business, created_at: 1.day.ago)
      expect(Business.all).to eq([business1, business2])
    end
  end
  
  describe "#average_rating" do
    let(:business) { Fabricate(:business) }
    let(:user) { Fabricate(:user) }

    it "returns nil if there are no reviews" do
      expect(business.average_rating).to eq(nil)
    end
    
    it "returns the average rating of the business reviews" do
      review1 = Fabricate(:review, rating: 3, business: business, user: user)
      review2 = Fabricate(:review, rating: 5, business: business, user: user)
      expect(business.average_rating).to eq(4)    
    end
  end
end