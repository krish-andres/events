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

  it "requires a name" do
    event = Event.new(name: "")
    
    event.valid?

    expect(event.errors[:name].any?).to eq(true)
  end

  it "requires a location" do
    event = Event.new(location: "")
    
    event.valid?

    expect(event.errors[:location].any?).to eq(true)
  end

  it "requires a 'starts at' time" do
    event = Event.new(starts_at: "")
    
    event.valid?

    expect(event.errors[:starts_at].any?).to eq(true)
  end

  it "requires a description" do
    event = Event.new(description: "")
    
    event.valid?

    expect(event.errors[:description].any?).to eq(true)
  end

  it "requires a description under 500 characters" do
    event = Event.new(description: "X" * 501)
    
    event.valid?

    expect(event.errors[:description].any?).to eq(true)
  end

  it "accepts a positive price" do
    event = Event.new(price: 10.00)

    event.valid?

    expect(event.errors[:price].any?).to eq(false)
  end

  it "accepts a price of $0" do
    event = Event.new(price: 0.00)

    event.valid?

    expect(event.errors[:price].any?).to eq(false)
  end

  it "rejects a negative price" do
    event = Event.new(price: -10.00)

    event.valid?

    expect(event.errors[:price].any?).to eq(true)
  end

  it "accepts a positive capacity" do
    event = Event.new(capacity: 100)

    event.valid?

    expect(event.errors[:capacity].any?).to eq(false)
  end

  it "rejects a capacity of 0" do
    event = Event.new(capacity: 0)

    event.valid?

    expect(event.errors[:capacity].any?).to eq(true)
  end

  it "rejects a negative capacity" do
    event = Event.new(capacity: -20)

    event.valid?

    expect(event.errors[:capacity].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file|
      event = Event.new(image_file_name: file)
      event.valid?
      expect(event.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file|
      event = Event.new(image_file_name: file)
      event.valid?
      expect(event.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "is valid with example attributes" do
    event = Event.new(event_attributes)

    expect(event.valid?).to eq(true)
  end
end
