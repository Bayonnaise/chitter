require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'rest_client'

require_relative 'models/user'
require_relative 'models/post'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'

set :views, './app/views'
set :public_dir, './public'
enable :sessions
set :session_secret, 'mysession'

use Rack::Flash
use Rack::MethodOverrideq

get '/' do
	@posts = Post.all
  erb :index
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.new(:username => params[:username],
							:email => params[:email],
							:name => params[:name],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])

	if @user.save 
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/sessions/new' do
	erb :"sessions/new"
end

post '/sessions' do
	username, password = params[:username], params[:password]
	user = User.authenticate(username, password)

	if user
		session[:user_id] = user.id
		redirect to('/')
	else
		flash[:errors] = ["The username or password is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions' do
	session[:user_id] = nil
	flash[:notice] = "Come back soon!"
	redirect to('/')
end

