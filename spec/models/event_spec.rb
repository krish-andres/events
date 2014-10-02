require 'spec_helper'

describe "An Event" do
  
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

  it "has many registrations" do
    event = Event.new(event_attributes)

    registration1 = event.registrations.new(registration_attributes)
    registration2 = event.registrations.new(registration_attributes)

    expect(event.registrations).to include(registration1)
    expect(event.registrations).to include(registration2)
  end

  it "deletes associated registrations" do
    event = Event.create!(event_attributes)
    event.registrations.create(registration_attributes)

    expect { 
      event.destroy
    }.to change(Event, :count).by(-1)
  end

  it "is sold out if no spots are left" do
    event = Event.new(event_attributes(capacity: 0))

    expect(event.sold_out?).to be_true
  end

  it "is not sold out if spots are available" do
    event = Event.new(event_attributes(capacity: 10))

    expect(event.sold_out?).to be_false
  end

  it "decrements spots left when a registration is created" do
    event = Event.create!(event_attributes)
    event.registrations.create!(registration_attributes)

    expect { 
      event.registrations.create(registration_attributes)
    }.to change(event, :spots_left).by(-1)
  end

  it "has likers" do
    event = Event.new(event_attributes)
    liker1 = User.new(user_attributes(username: "liker1", email: "liker1@example.com"))
    liker2 = User.new(user_attributes(username: "liker2", email: "liker2@example.com"))

    event.likes.new(user: liker1)
    event.likes.new(user: liker2)

    expect(event.likers).to include(liker1)
    expect(event.likers).to include(liker2)
  end

  context "free query" do
    it "returns upcoming free events" do
      event = Event.create!(event_attributes(starts_at: 3.months.from_now, price: 0.00))

      expect(Event.free).to include(event)
    end

    it "does not return upcoming non-free events" do
      event = Event.create!(event_attributes(starts_at: 3.months.from_now, price: 20.00))

      expect(Event.free).not_to include(event)
    end

    it "does not return past free events" do
      event = Event.create!(event_attributes(starts_at: 3.months.ago, price: 0.00))

      expect(Event.free).not_to include(event)
    end
  end

  context "upcoming query" do
    
    it "returns the events with a start date in the future" do
      event = Event.create!(event_attributes(starts_at: 3.months.from_now))
      
      expect(Event.upcoming).to include(event)
    end

    it "does not return the events with a start date in the past" do
      event = Event.create!(event_attributes(starts_at: 3.months.ago))
      
      expect(Event.upcoming).not_to include(event)
    end
      
    it "list upcoming events by date, with the soonest event(s) first" do
      event1 = Event.create!(event_attributes(name: "Event 1", starts_at: 10.days.from_now))
      event2 = Event.create!(event_attributes(name: "Event 2", starts_at: 20.days.from_now))
      event3 = Event.create!(event_attributes(name: "Event 3", starts_at: 40.days.from_now))

      expect(Event.upcoming).to eq([event1, event2, event3])
    end

  end

  context "past query" do
    it "returns events that occurred in the past"  do
      event = Event.create!(event_attributes(starts_at: 3.months.ago))

      expect(Event.past).to include(event)
    end

    it "does not return events that occur in the future" do
      event = Event.create!(event_attributes(starts_at: 3.months.from_now))

      expect(Event.past).not_to include(event)
    end

    it "list past events by date, with the most recent event(s) first" do
      event1 = Event.create!(event_attributes(name: "Event 1", starts_at: 10.days.ago))
      event2 = Event.create!(event_attributes(name: "Event 2", starts_at: 20.days.ago))
      event3 = Event.create!(event_attributes(name: "Event 3", starts_at: 40.days.ago))

      expect(Event.past).to eq([event1, event2, event3])
    end
  end

  context "recently added query" do
    before do
      @event1 = Event.create!(event_attributes(name: "Event 1", created_at: 3.months.ago))
      @event2 = Event.create!(event_attributes(name: "Event 2", created_at: 2.months.ago))
      @event3 = Event.create!(event_attributes(name: "Event 3", created_at: 1.months.ago))
      @event4 = Event.create!(event_attributes(name: "Event 4", created_at: 1.week.ago))
      @event5 = Event.create!(event_attributes(name: "Event 5", created_at: 1.day.ago))
    end

    it "returns a specified number of events ordered with the most recently added event first" do
      expect(Event.recently_added(2)).to eq([@event5, @event4])
    end

    it "returns a default number of 5 events ordered with the most recently added event first" do
      expect(Event.recently_added).to eq([@event5, @event4, @event3, @event2, @event1])
    end
  end

  it "generates a slug when it's created" do
    event = Event.create!(event_attributes(name: "An Exciting Event"))

    expect(event.slug).to eq("an-exciting-event")
  end

  it "requires a unique name" do
    event1 = Event.create!(event_attributes)
    event2 = Event.new(name: event1.name)

    event2.valid?
    expect(event2.errors[:name].first).to eq("has already been taken")
  end

  it "requires a unique slug" do
    event1 = Event.create!(event_attributes)
    event2 = Event.new(slug: event1.slug)

    event2.valid?
    expect(event2.errors[:slug].first).to eq("has already been taken")
  end
end


