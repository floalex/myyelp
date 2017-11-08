require 'rails_helper'

feature "User signs in and signs out" do
  scenario "signing with valid email and password" do
    alice = Fabricate(:user)
    
    sign_in(alice)
    expect(page).to have_content(alice.full_name)
    
    sign_out(alice)
    expect(page).to have_content('Sign In')
  end
  
  scenario "signing with invalid email or password" do
    alice = Fabricate(:user)
    
    visit sign_in_path
    
    sign_with_invalid_info(alice)
    
    expect(page).to have_content('Incorrect email or password.')
  end
  
  def sign_with_invalid_info(user)
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password + 'error'
  
    click_button "Sign In"
  end
end