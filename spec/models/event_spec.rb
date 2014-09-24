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
end
