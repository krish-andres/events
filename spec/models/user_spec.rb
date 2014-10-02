require 'spec_helper'

describe "A User" do
  
  it "requires a name" do
    user = User.new(name: "")

    user.valid?

    expect(user.errors[:name].any?).to eq(true)
  end

  it "requires a username" do
    user = User.new(username: "")

    user.valid?

    expect(user.errors[:username].any?).to eq(true)
  end

  it "requires a email" do
    user = User.new(email: "")

    user.valid?

    expect(user.errors[:email].any?).to eq(true)
  end

  it "requires a unique username" do
    user = User.create!(user_attributes)
    user2 = User.new(username: user.username.upcase)

    user2.valid?

    expect(user2.errors[:username].first).to eq("has already been taken")
  end

  it "accepts properly formatted email addresses" do
    emails = %w[foobar@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[foo@ @example.com user. .com@]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case-insensitive email" do
    user = User.create!(user_attributes)
    user2 = User.new(email: user.email.upcase)

    user2.valid?

    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.new(user_attributes)

    expect(user.valid?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")

    user.valid?

    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation when password is present" do
    user = User.new(password: "secret", password_confirmation: "")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires a password confirmation to match the password" do
    user = User.new(password: "secret", password_confirmation: "mismatch")

    user.valid?

    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "requires a matching password and confirmation when creating" do
    user = User.create!(user_attributes(password: "secret", password_confirmation: "secret"))

    expect(user.valid?).to eq(true)
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""

    expect(user.valid?).to eq(true)
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = User.new(password: "secret")

    expect(user.password_digest.present?).to eq(true)
  end

  it "has registrations" do
    user = User.new(user_attributes)
    event1 = Event.new(event_attributes(name: "Event 1"))
    event2 = Event.new(event_attributes(name: "Event 2"))

    registration1 = event1.registrations.new(how_heard: "Twitter")
    registration1.user = user
    registration1.save!

    registration2 = event2.registrations.new(how_heard: "Blog Post")
    registration2.user = user
    registration2.save!

    expect(user.registrations).to include(registration1)
    expect(user.registrations).to include(registration2)
  end

  it "has liked events" do
    user = User.new(user_attributes)
    event1 = Event.new(event_attributes(name: "Event 1"))
    event2 = Event.new(event_attributes(name: "Event 2"))

    user.likes.new(event: event1)
    user.likes.new(event: event2)

    expect(user.liked_events).to include(event1)
    expect(user.liked_events).to include(event2)
  end
end

describe "Authenticate" do
  before { @user = User.create!(user_attributes) }

  it "returns non-true if the email doesn't match" do
    expect(User.authenticate("nomatch", @user.password)).not_to eq(true) 
  end

  it "return non-true if the password doesn't match" do
    expect(User.authenticate(@user.email, "nomatch")).not_to eq(true)
  end

  it "returns the user if the email and password match" do
    expect(User.authenticate(@user.email, @user.password)).to eq(@user)
  end
end
