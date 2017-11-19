require 'rails_helper'

feature "User creates reviews for the associated business" do
  scenario "user adds reviews after seeing the business show page" do
    business = Fabricate(:business)
    
    sign_in
    
    visit_review_page(business)
    
    write_valid_review
    
    expect_business_page_include_review(business)
  end
  
  def visit_review_page(business)
    visit business_path(business)
    click_link "Write a Review"
    expect(page).to have_content(business.name)
  end
  
  def write_valid_review
    within "#new_review" do
      choose "review_rating_3"
      fill_in "review[content]", with: "Not bad."
      click_button 'Submit Review'
    end
  end
  
  def expect_business_page_include_review(business)
    visit business_path(business)
    expect(page).to have_content("Not bad.")
  end
  
end