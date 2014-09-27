require 'spec_helper'

describe "An Event" do
  
  it "is free is the price is $0" do
    event = Event.new(price: 0.00)

    expect(event.free?).to eq(true)
  end

  it "is not free is the price is more than $0" do
    event = Event.new(price: 20.00)

    expect(event.free?).to eq(false)
  end

  it "isn't upcoming if the event occured in the past" do
    event = Event.create!(event_attributes(starts_at: 10.days.ago))

    expect(Event.upcoming).not_to include(event)
  end

  it "is upcoming if the event occurs in the future" do
    event = Event.create!(event_attributes(starts_at: 10.days.from_now))

    expect(Event.upcoming).to include(event)
  end

  it "list the events by date, with the soonest event(s) first" do
    event1 = Event.create!(event_attributes(starts_at: 10.days.from_now))
    event2 = Event.create!(event_attributes(starts_at: 20.days.from_now))
    event3 = Event.create!(event_attributes(starts_at: 40.days.from_now))

    expect(Event.upcoming).to eq([event1, event2, event3])
  end
end
