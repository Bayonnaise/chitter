require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do	
	scenario "when logged out" do
		expect(lambda {sign_up}).to change(User, :count).by(1)
		expect(page).to have_content("Welcome, Dave")
		expect(User.first.email).to eq("dave@email.com")
	end

	scenario "with a password that doesn't match" do
		expect(lambda {sign_up('Davetest', 'dave@email.com', 'Dave', 'pass', 'wrong')}).to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do    
    expect(lambda { sign_up }).to change(User, :count).by(1)
    expect(lambda { sign_up('Davetest2') }).to change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end
end

feature "User signs in" do
	before(:each) do
		User.create(:username => "Davetest",
								:email => "dave@email.com",
								:name => "Dave",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, Dave")
		sign_in("Davetest", 'test')
		expect(page).to have_content("Welcome, Dave")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, Dave")
		sign_in("Davetest", 'test1')
		expect(page).not_to have_content("Welcome, Dave")
	end
end

feature "User signs out" do
	before(:each) do
		User.create(:username => "Davetest",
								:email => "dave@email.com",
								:name => "Dave",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "while signed in" do
		sign_in("Davetest", 'test')
		click_button('Sign out')
		expect(page).not_to have_content("Welcome, Dave")
		expect(page).to have_content("Come back soon!")
	end
end