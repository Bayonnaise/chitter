get '/' do
	@posts = Post.all
  erb :index
end

get '/profile' do
	@posts = Post.all(:user_id => current_user.id)
	erb :index
end