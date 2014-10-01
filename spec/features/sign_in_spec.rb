require 'spec_helper'

describe "Signing in" do
  
  it "prompts for an email and password" do
    visit root_url
    click_link 'Sign In'

    expect(current_path).to eq(signin_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it "signs in the user if the email/password combination is valid" do
    user = User.create!(user_attributes)

    visit root_url
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back, #{user.username}")
    expect(page).to have_link(user.username)
    expect(page).to have_link('Account Settings')
    expect(page).to have_link('Sign Out')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "does not sign in the user if the email/password combination is invalid" do
    user = User.create!(user_attributes)

    visit signin_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'mismatch'
    click_button 'Sign In'

    expect(page).to have_text('Invalid')
    expect(page).not_to have_link(user.username)
    expect(page).not_to have_link('Account Settings')
    expect(page).not_to have_link('Sign Out')
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
  end

  it "redirects to the intended page" do
    user = User.create!(user_attributes)

    visit users_url
    
    expect(current_path).to eq(signin_path)

    sign_in(user)

    expect(current_path).to eq(users_path)
  end
end
