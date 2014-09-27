require 'spec_helper'

describe "Showing an event" do
  
  it "shows the event details" do
    event = Event.create!(event_attributes(price: 20.00))

    visit event_url(event)

    expect(page).to have_text(event.name)
    expect(page).to have_text(event.description)
    expect(page).to have_text(event.location)
    expect(page).to have_text(event.starts_at)
    expect(page).to have_text(event.capacity)
    expect(page).to have_selector("img[src$='#{event.image_file_name}']")
  end

  it "shows 'Free!' if the event costs $0" do
    event = Event.create!(event_attributes(price: 0.00))

    visit event_url(event)
    
    expect(page).to have_text('Free!')
  end

  it "shows the price if the event is more than $0" do
    event = Event.create!(event_attributes(price: 20.00))

    visit event_url(event)
    
    expect(page).to have_text("$20.00")
  end
end
