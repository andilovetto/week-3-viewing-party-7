require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "123123123", password_confirmation: "123123123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "123412341234", password_confirmation: "123412341234")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  xit 'lists out existing users' do 
    
    user1 = User.create(name: "User One", email: "user1@test.com", password: "123123123", password_confirmation: "123123123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "123412341234", password_confirmation: "123412341234")
    
    expect(page).to have_content('Existing Users:')
    
    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end
  
  it "has a link for logging users in" do
    expect(page).to have_content("Log In")
    click_link "Log In"
    expect(current_path).to eq(login_path)
  end
end
