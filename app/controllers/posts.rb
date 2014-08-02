# get '/posts/new' do
# 	erb :"posts/new"
# end

post '/posts' do 
	user_id = current_user.id
	text = params[:"post-content"]
	time = Time.new
	@post = Post.new(:text => text, :timestamp => time, :user_id => user_id)
	unless @post.save
		flash.now[:errors] = @post.errors.full_messages
	end
	redirect to ('/')
end