module Helpers

	def sign_up(username = "Davetest", email="dave@email.com", name="Dave Smith", password="pass", password_confirmation="pass")
		visit '/'
		fill_in 'signup_username', :with => username
		fill_in 'signup_name', :with => name
		fill_in 'signup_email', :with => email
		fill_in 'signup_password', :with => password
		fill_in 'signup_password_confirmation', :with => password_confirmation
		click_button("Sign up")
	end

	def sign_in(username, password)
		visit '/'
		fill_in 'login_username', :with => username
		fill_in 'login_password', :with => password
		click_button("Sign in")
	end

	def add_post(text)
    fill_in 'post-content', :with => text
    click_button 'Post'
  end
	
end