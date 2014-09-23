require 'spec_helper'

describe "Listing the Events" do
  
  it "shows the events" do
    event1 = Event.create!(event_attributes)
    event2 = Event.create!(name: "Eventastic!", location: "Dallas, TX", price: 20.00, description: "A fantastic event indeed! Two thumbs up!", starts_at: 10.days.from_now) 

    visit events_url

    expect(page).to have_text("2 Events")
    expect(page).to have_text(event1.name)
    expect(page).to have_text(event2.name)

    expect(page).to have_text("$20.00")
    expect(page).to have_text(event2.location)
    expect(page).to have_text(event2.description)
    expect(page).to have_text(event2.starts_at)
  end
end
