require 'spec_helper'

describe "Navigating Events" do
  
  it "allows navigation from the show page to the listing page" do
    event = Event.create!(event_attributes)

    visit event_url(event)
    click_link 'Upcoming'

    expect(current_path).to eq(events_path)
  end

  it "allows navigation from the listing page to the show page" do
    event = Event.create!(event_attributes)

    visit events_url
    click_link event.name

    expect(current_path).to eq(event_path(event))
  end
end
