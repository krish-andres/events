require 'spec_helper'

describe "Creating an event" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end
  
  it "creates the event and shows the new event's details" do
    
    visit events_url
    click_link 'Add New Event'

    expect(current_path).to eq(new_event_path)

    fill_in 'Name', with: "New Event"
    fill_in 'Description', with: "This is the description for a new event"
    fill_in 'Location', with: "Denver, CO"
    fill_in 'Price', with: "20.00"
    select (Time.now.year + 1).to_s, from: "event_starts_at_1i"
    fill_in 'Capacity', with: '75'
    fill_in 'Image file name', with: 'event.png'

    click_button 'Create Event'
    
    expect(current_path).to eq(event_path(Event.last))
    expect(page).to have_text("New Event")
  end

  it "cannot create an event with invalid data" do
    visit new_event_url

    expect {
      click_button 'Create Event'
    }.not_to change(Event, :count)

   expect(page).to have_text('error') 
  end
end
