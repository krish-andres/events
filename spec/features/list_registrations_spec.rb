require 'spec_helper'

describe "Viewing a list of events" do
  
  it "shows the registrations for a specific event" do
    event1 = Event.create!(event_attributes(name: "Eventure"))
    reg1 = event1.registrations.create!(registration_attributes(name: "Joe", email: "joe@example.com"))
    reg2 = event1.registrations.create!(registration_attributes(name: "Bob", email: "bob@example.com"))

    event2 = Event.create!(event_attributes(name: "Adventure"))
    reg3 = event2.registrations.create!(registration_attributes(name: "Jim", email: "jim@example.com"))

    visit event_registrations_url(event1)

    expect(page).to have_text(reg1.name)
    expect(page).to have_text(reg2.name)
    expect(page).not_to have_text(reg3.name)
  end
end
