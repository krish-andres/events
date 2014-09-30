require 'spec_helper'

describe "Editing an event" do
  
  it "updates the event and shows the event's updated details" do
    event = Event.create!(event_attributes)

    visit event_url(event)
    click_link 'Edit'

    expect(current_path).to eq(edit_event_path(event))
    expect(find_field('Name').value).to eq(event.name)

    fill_in 'Name', with: 'Updated Event'
    click_button 'Update Event'

    expect(current_path).to eq(event_path(event))
    expect(page).to have_text("Updated Event")
  end

  it "does not update the event with invalid data" do
    event = Event.create!(event_attributes)

    visit edit_event_url(event)
    fill_in 'Name', with: ""
    click_button 'Update Event'

    expect(page).to have_text('error')
  end
end
