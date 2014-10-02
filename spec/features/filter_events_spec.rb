require 'spec_helper'

describe "Filtering Events" do
  
  it "shows past events" do
    event = Event.create!(event_attributes(starts_at: 10.days.ago))

    visit events_url
    click_link 'Past'

    expect(current_path).to eq('/events/past')
    expect(page).to have_text(event.name)
  end

  it "shows free events" do
    event = Event.create!(event_attributes(price: 0.00))

    visit events_url
    click_link 'Free'

    expect(current_path).to eq('/events/free')
    expect(page).to have_text(event.name)
  end

  it "shows recently added events" do
    event = Event.create!(event_attributes(created_at: 1.hour.ago))

    visit events_url
    click_link 'Recently Added'

    expect(current_path).to eq('/events/recently_added')
    expect(page).to have_text(event.name) 
  end
end
