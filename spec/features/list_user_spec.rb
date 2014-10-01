require 'spec_helper'

describe "Listing the users" do
  
  it "shows the list of non-admin users" do
    user1 = User.create!(user_attributes(username: "user1", email: "user1@example.com"))
    user2 = User.create!(user_attributes(username: "user2", email: "user2@example.com"))
    user3 = User.create!(user_attributes(username: "user3", email: "user3@example.com"))

    visit users_url

    expect(page).to have_text(user1.username)
    expect(page).to have_text(user2.username)
    expect(page).to have_text(user3.username)
  end
end
