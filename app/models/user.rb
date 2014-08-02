require 'bcrypt'

class User

	attr_reader :password
	attr_accessor :password_confirmation

	include DataMapper::Resource

	validates_confirmation_of :password

	property :id, Serial
	property :username, String, :unique => true, :message => "This username is already taken", :required => true
	property :email, String, :format => :email_address, :unique => true, :message => "This email is already taken", :required => true
	property :name, String, :required => true
	property :password_digest, Text
	property :password_token, String, :length => 64 
	property :password_token_timestamp, Time

	has n, :posts

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(username, password)
		user = first(:username => username)

		if user && BCrypt::Password.new(user.password_digest) == password
			 user
		else
			nil
		end
	end

end