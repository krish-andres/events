# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create!([
  {
    name: "Eventure", 
    description: "Are you ready for the adventure of a lifetime?!", 
    location: "Los Angeles, CA", 
    starts_at: 20.days.from_now, 
    price: 20.00, 
    capacity: 100 
  }, 
  {
    name: "EDMpire", 
    description: "Something about electronic dance music...", 
    location: "Dallas, TX", 
    starts_at: 40.days.from_now, 
    price: 0.00, 
    capacity: 300
  }, 
  {
    name: "InsomniVent", 
    description: "Have trouble sleeping? Attend the world's best event for insomniacs!", 
    location: "Seattle, WA", 
    starts_at: 80.days.from_now, 
    price: 10.00, 
    capacity: 200
  }, 
  {
    name: "EventXpired",
    description: "Uh Oh! Looks like it's too late to attend this event!", 
    location: "New York City, NY", 
    starts_at: 20.days.ago, 
    price: 10.00, 
    capacity: 200
  }
])
