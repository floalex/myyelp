require 'rails_helper'

feature "User sees other user's profile page" do
  given(:user) { Fabricate(:user) }
  given(:review1) { Fabricate(:review, user: user, business: Fabricate(:business)) }
  given(:review2) { Fabricate(:review, user: user, business: Fabricate(:business)) }
  
  scenario "user sees another user's profile" do
    visit user_path(user)
    
    expect_to_see_basic_info
    expect_to_see_user_reviews([review2, review1])
  end
  
  def expect_to_see_basic_info
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.zipcode)
  end
  
  def expect_to_see_user_reviews(reviews)
    page.all('.review').each_with_index do |review, index|
      expect(review).to have_content(reviews[index].content)
      expect(review).to have_content(reviews[index].rating)
    end
  end
end