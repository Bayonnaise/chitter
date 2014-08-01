module SessionHelpers

	def sign_up(username = "Davetest", email="dave@email.com", name="Dave Smith", password="pass", password_confirmation="pass")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		expect(page.status_code).to eq(200)
		fill_in :username, :with => username
		fill_in :name, :with => name
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end

	def sign_in(username, password)
		visit '/sessions/new'
		fill_in 'username', :with => username
		fill_in 'password', :with => password
		click_button("Sign in")
	end
end