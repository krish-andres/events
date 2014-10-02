require 'spec_helper'

describe "A Registration" do
  
  it "belongs to an event" do
    event = Event.create!(event_attributes)

    registration = event.registrations.new(registration_attributes)

    expect(registration.event).to eq(event)
  end

  it "is valid with example attributes" do
    registration = Registration.new(registration_attributes)

    expect(registration.valid?).to eq(true)
  end

  it "accepts any how heard option on an approved list" do
    options = Registration::HOW_HEARD_OPTIONS
    options.each do |option|
      registration = Registration.new(how_heard: option)
      registration.valid?
      expect(registration.errors[:how_heard].any?).to eq(false)
    end
  end
  
  it "rejects any how heard option not on an approved list" do
    options = %w[foo bar baz hello yomomma]
    options.each do |option|
      registration = Registration.new(how_heard: option)
      registration.valid?
      expect(registration.errors[:how_heard].any?).to eq(true)
    end
  end
end
