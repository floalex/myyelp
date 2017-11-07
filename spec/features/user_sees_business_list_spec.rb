require 'rails_helper'

feature "User can see a list of businesses" do
  scenario "user sees a business list when visiting the home page" do
    business1 = Fabricate(:business)
    business2 = Fabricate(:business)
    
    visit home_path
    expect_business_with_details(business1)
    expect_business_with_details(business2)
  end
  
  def expect_business_with_details(business)
    expect(page).to have_content(business.name)
    expect(page).to have_content(business.address)
    expect(page).to have_content(business.city)
    expect(page).to have_content(business.state)
    expect(page).to have_content(business.zipcode)
    expect(page).to have_content("(#{business.phone.slice(0..2)}) #{business.phone.slice(3..5)}-#{business.phone.slice(6..9)}")
  end
end