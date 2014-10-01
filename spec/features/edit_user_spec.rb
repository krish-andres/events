require 'spec_helper'

describe "Editing a user" do
  
  it "saves the user's updated info" do
    user = User.create!(user_attributes)

    visit user_url(user)
    click_link 'Edit Account'

    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('Name').value).to eq(user.name)

    fill_in 'Name', with: "Updated Name"
    click_button 'Update Account'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Updated Name")
  end

  it "does not save the user with invalid data" do
    user = User.create!(user_attributes)

    visit edit_user_path(user)
    fill_in 'Name', with: ""
    click_button 'Update Account'

    expect(page).to have_text('error')
  end
end
