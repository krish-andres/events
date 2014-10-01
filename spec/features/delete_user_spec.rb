require 'spec_helper'

describe "Deleting a user" do
  
  it "deletes the user and redirects to the home page" do
    user = User.create!(user_attributes)

    sign_in(user)
    visit user_url(user)
    click_link 'Delete Account'

    expect(current_path).to eq(root_path)
    
    visit users_url
    expect(page).not_to have_text(user.username)
  end

  it "automatically signs out the user" do
    user = User.create!(user_attributes)

    sign_in(user)
    visit user_path(user)
    click_link 'Delete Account'

    expect(page).to have_link('Sign In')
    expect(page).not_to have_link('Sign Out')
  end
end
