require 'spec_helper'
require_relative 'helpers/session'
include Helpers

feature "User signs up" do	
	scenario "when logged out" do
		expect(lambda {sign_up}).to change(User, :count).by(1)
		expect(page).to have_content("Davetest")
		expect(User.first.email).to eq("dave@email.com")
	end

	scenario "with a password that doesn't match" do
		expect(lambda {sign_up('Davetest', 'dave@email.com', 'Dave', 'pass', 'wrong')}).to change(User, :count).by(0)
		expect(current_path).to eq('/')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do    
    expect(lambda { sign_up }).to change(User, :count).by(1)
    click_button('Sign out')
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
		expect(page).not_to have_content("Davetest")
		sign_in("Davetest", 'test')
		expect(page).to have_content("Davetest")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Davetest")
		sign_in("Davetest", 'test1')
		expect(page).not_to have_content("Davetest")
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
		expect(page).not_to have_content("Davetest")
		expect(page).to have_content("Come back soon!")
	end
end

feature 'User requests password reset' do
	before(:each) do
    User.create(:username => "Davetest",
								:email => "dave@email.com",
								:name => "Dave",
								:password => 'test',
								:password_confirmation => 'test')
  end

  scenario 'when requesting reset' do
  	visit '/'
  	fill_in 'forgot_email', :with => "dave@email.com"
  	expect(Messenger).to receive(:send_email).with(User.first)
  	click_button "Reset password"
  	expect(page).to have_content("Password reset email sent")
  end

  scenario 'when resetting password' do
  	User.first.update( :password_token => 123, :password_token_timestamp => Time.now - 100)
  	visit "/users/reset_password/123"
  	fill_in 'password', :with => "dog"
  	fill_in 'password_confirmation', :with => "dog"
  	click_button "Confirm"
  	expect(User.first.password_token).to be nil
  end
end