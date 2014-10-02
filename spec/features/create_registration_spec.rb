require 'spec_helper'

describe "Creating a registration" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end
  
  it "saves the registration" do
    event = Event.create!(event_attributes)

    visit event_url(event)
    click_link 'Register!'

    expect(current_path).to eq(new_event_registration_path(event))

    select "Twitter", from: "registration_how_heard"

    click_button 'Register!'
    expect(current_path).to eq(event_registrations_path(event))
    expect(page).to have_text(@user.username)
  end

  it "does not save the review if it's invalid" do
    event = Event.create!(event_attributes)
    
    visit new_event_registration_path(event)

    expect { 
      click_button 'Register!'
    }.not_to change(Registration, :count)
    expect(page).to have_text('error')

  end
end
