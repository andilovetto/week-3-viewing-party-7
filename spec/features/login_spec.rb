require 'rails_helper'

RSpec.describe "User Login Page" do
  describe "user login page" do

    let!(:user) { User.create!(name: "andi", email: "andilovetto@gmail.com", password: "123123123", password_confirmation: "123123123") }

    context "when a user inputs a unique email and password" do

      it "redirects to user dashboard after successful login" do
        visit login_path
        
        expect(page).to have_content("login form")
        expect(page).to have_content("Email")
        fill_in :email, with: "andilovetto@gmail.com"

        expect(page).to have_content("Password")
        fill_in :password, with: "123123123"

        click_button "login"

        expect(current_path).to eq(dashboard_path)
      end      

      it "redirects to user login form after unsuccessful login" do
        visit login_path
        
        expect(page).to have_content("login form")
        expect(page).to have_content("Email")
        fill_in :email, with: "andilovetto@gmail.com"
        
        expect(page).to have_content("Password")
        fill_in :password, with: "notmypassword"
        
        click_button "login"
        
        expect(page).to have_content("Sorry, your credentials are bad")
        expect(current_path).to eq(login_path)
      end      
    end
  end
end