def event_attributes(overrides = {})
  {
    name: "Eventure", 
    description: "Are you ready for the E(AD)venture of your life?!?", 
    price: 50.00, 
    starts_at: 20.days.from_now, 
    location: "San Francisco, CA"
  }.merge(overrides)
end
