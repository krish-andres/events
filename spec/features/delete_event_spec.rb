require 'spec_helper'

describe "Deleting an event" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end
  
  it "delete the event and redirects to the home page" do
    event = Event.create!(event_attributes)

    visit event_url(event)
    click_link 'Delete'

    expect(current_path).to eq(events_path)
    expect(page).not_to have_text(event.name)
  end
end
