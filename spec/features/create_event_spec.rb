require 'spec_helper'

describe "Creating an event" do
  
  it "creates the event and shows the new event's details" do
    
    visit events_url
    click_link 'Add New Event'

    expect(current_path).to eq(new_event_path)

    fill_in 'Name', with: "New Event"
    fill_in 'Description', with: "This is the description for a new event"
    fill_in 'Location', with: "Denver, CO"
    fill_in 'Price', with: "20.00"
    select (Time.now.year + 1).to_s, from: "event_starts_at_1i"
    fill_in 'Event Capacity', with: '75'
    fill_in 'Event Image File Name', with: 'event.png'

    click_button 'Create Event'
    
    expect(current_path).to eq(event_path(Event.last))
    expect(page).to have_text("New Event")
  end
end
