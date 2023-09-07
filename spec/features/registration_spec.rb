require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "123123123"
    fill_in :user_password_confirmation, with: "123123123"

    click_button 'Create New User'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "123123123", password_confirmation: "123123123")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it 'does not create a user if password and password confirmation do not match' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "123123123", password_confirmation: "notmatching")

    visit register_path
    
    fill_in :user_name, with: 'andi'
    fill_in :user_email, with:'andi@gmail.com'
    fill_in :user_password, with: "123123123"
    fill_in :user_password_confirmation, with: "notmatching"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end
