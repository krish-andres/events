def event_attributes(overrides = {})
  {
    name: "Eventure", 
    description: "Are you ready for the E(AD)venture of your life?!?", 
    price: 50.00, 
    starts_at: 20.days.from_now, 
    location: "San Francisco, CA",
    capacity: 100
  }.merge(overrides)
end

def registration_attributes(overrides = {})
  { 
    name: "Example Name", 
    email: "user@example.com", 
    how_heard: "Twitter"
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: "Example User", 
    username: "exampleuser", 
    email: "user@example.com", 
    password: "foobar", 
    password_confirmation: "foobar"
  }.merge(overrides)
end
