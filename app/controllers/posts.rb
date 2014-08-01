get '/posts/new' do
	erb :"posts/new"
end

post '/posts' do 
	if current_user
		user_id = current_user.id
		text = params[:text]
		time = Time.new
		Post.create(:text => text, :timestamp => time, :user_id => user_id)
		redirect to ('/')
	else
		redirect to('/sessions/new')
	end
end