require 'rails_helper'

describe Business do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:phone) }
  
  describe "default scope" do
    it "returns the businesses in the reverse chronical order by created_at" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business, created_at: 1.day.ago)
      expect(Business.all).to eq([business1, business2])
    end
  end
end