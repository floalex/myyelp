require 'rails_helper'

describe Review do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :business }
  it { is_expected.to validate_presence_of :rating }
  it { is_expected.to validate_presence_of :content }
  
  let(:user) { Fabricate(:user) }
  let(:review) { Fabricate(:review, user: user, business: Fabricate(:business)) }
  
  describe "#user_full_name" do
    it "returns the full name of the associated user" do
      expect(review.user_full_name).to eq(user.full_name)
    end
  end
  
  describe "#user_reviews_count" do
    before do
      Fabricate(:review, user: user, business: Fabricate(:business))
    end
    
    it "returns the reviews count of the associated user" do
      expect(review.user_reviews_count).to eq(2)
    end
  end
end