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

  it "shows the event's likers and categories in the sidebar" do
    event = Event.create!(event_attributes)
    user = User.create!(user_attributes)
    event.likers << user

    category = Category.create!(name: "Category 1")
    event.categories << category

    visit event_url(event)
    within("aside#sidebar") do
      expect(page).to have_text(user.username)
      expect(page).to have_text(category.name)
    end
  end

  it "includes the event's title in the page title" do
    event = Event.create!(event_attributes)

    visit event_url(event)

    expect(page).to have_title("Events - #{event.name}")
  end

  it "has an SEO-friendly URL" do
    event = Event.create!(event_attributes(name: "An Exciting Event"))

    visit event_url(event)

    expect(current_path).to eq("/events/an-exciting-event")
  end
end
