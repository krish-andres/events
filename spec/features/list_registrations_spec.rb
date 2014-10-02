require 'spec_helper'

describe "Viewing a list of events" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end
  
  it "shows the registrations for a specific event" do
    event1 = Event.create!(event_attributes(name: "Eventure"))
    reg1 = event1.registrations.create!(registration_attributes(how_heard: "Twitter", user: @user))
    reg2 = event1.registrations.create!(registration_attributes(how_heard: "Blog Post", user: @user))

    event2 = Event.create!(event_attributes(name: "Adventure"))
    reg3 = event2.registrations.create!(registration_attributes(how_heard: "Other", user: @user))

    visit event_registrations_url(event1)

    expect(page).to have_text(reg1.how_heard)
    expect(page).to have_text(reg2.how_heard)
    expect(page).not_to have_text(reg3.how_heard)
  end
end
