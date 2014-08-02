# get '/users/new' do
# 	@user = User.new
# 	erb :"users/new"
# end

post '/users' do
	@user = User.new(:username => params[:signup_username],
							:email => params[:signup_email],
							:name => params[:signup_name],
							:password => params[:signup_password],
							:password_confirmation => params[:signup_password_confirmation])

	if @user.save 
		session[:user_id] = @user.id
	else
		flash[:errors] = @user.errors.full_messages
	end
	redirect to('/')
end

post '/users/reset_password' do
	email = params[:forgot_email]
	user = User.first(:email => email)
	password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	password_token_timestamp = Time.now
	user.update(:password_token => password_token, :password_token_timestamp => password_token_timestamp)

	Messenger.send_email(user)
	flash[:notice] = "Password reset email sent"
	redirect to('/')
end

get "/users/reset_password/:token" do
	@token = params[:token]
	@user = User.first(:password_token => @token)
	erb :"users/reset_password"
end

post "/users/password_updated" do
	@token = params[:token]
	@user = User.first(:password_token => @token)
	updatedpass = params[:password]
	@user.update(:password_digest => BCrypt::Password.create(updatedpass),
								:password_token => nil,
								:password_token_timestamp => nil) 
	redirect to('/')
end