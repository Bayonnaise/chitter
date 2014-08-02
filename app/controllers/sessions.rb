post '/sessions' do
	username, password = params[:login_username], params[:login_password]
	user = User.authenticate(username, password)

	if user
		session[:user_id] = user.id
	else
		flash[:errors] = ["The username or password is incorrect"]
	end
	redirect to('/')
end

delete '/sessions' do
	session[:user_id] = nil
	flash[:notice] = "Come back soon!"
	redirect to('/')
end