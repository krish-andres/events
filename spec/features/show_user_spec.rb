require 'spec_helper'

describe "Showing a user" do
  
  it "shows the user's profile page" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text(user.name)
  end

  it "shows the user's liked events in the sidebar" do
    user = User.create!(user_attributes)
    event = Event.create!(event_attributes)

    user.liked_events << event

    sign_in(user)
    visit user_url(user)

    within("aside#sidebar") do
      expect(page).to have_text(event.name)
    end
  end

  it "includes the user's username in the page title" do
    user = User.create!(user_attributes)

    sign_in(user)
    visit user_url(user)

    expect(page).to have_title("Events - #{user.username}")
  end

  it "has an SEO-friendly URL" do
    user = User.create!(user_attributes(username: "phoenix", email: "user@example.com"))
    
    sign_in(user)
    visit user_url(user)

    expect(current_path).to eq("/users/phoenix")
  end
end
