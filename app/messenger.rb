class Messenger

	API_KEY = ENV['MAILGUN_API_KEY']
	API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/postmaster@app27923148.mailgun.org"

	def self.send_email(user)
		if ENV['RACK_ENV'] == 'development'
			@link = "http://localhost:9292/users/reset_password/#{user.password_token}"
		else
			@link = "http://fast-plateau-8582.herokuapp.com/users/reset_password/#{user.password_token}"
		end

	  RestClient.post "https://api:#{API_KEY}"\
	  "@api.mailgun.net/v2/app28022340.mailgun.org/messages",
	  :from => "Chitter <me@app28022340.mailgun.org>",
	  :to => user.email,
	  :subject => "Password reset",
	  :text => "Click this link to reset your password: #{@link}"
	end

end