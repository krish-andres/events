require 'spec_helper'

describe "Creating a user" do
  
  it "creates the user and saves it to the database" do

    visit root_url
    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in 'Name', with: "Example Name"
    fill_in 'Username', with: "exampleuser"
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "secret"
    fill_in 'Password Confirmation', with: "secret"
    click_button 'Create Account'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_text("exampleuser")
  end

  it "does not create a user with invalid data" do
    visit signup_path
    expect { 
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end
