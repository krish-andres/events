require 'spec_helper'

describe "Deleting a user" do
  
  it "deletes the user and redirects to the home page" do
    user = User.create!(user_attributes)

    visit user_url(user)
    click_link 'Delete Account'

    expect(current_path).to eq(root_path)
    
    visit users_url
    expect(page).not_to have_text(user.username)
  end
end
