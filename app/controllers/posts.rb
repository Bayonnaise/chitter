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

get '/posts/reply/:id' do
	@original_id = params['id']
	@posts = Post.all
	erb :index
end

post '/posts/reply/:id' do
	@original_id = params['id']
	user_id = current_user.id
	text = params[:"reply-text"]
	time = Time.new
	@post = Post.new(:text => text, :timestamp => time, :user_id => user_id, :reply_to_id => @original_id)
	unless @post.save
		flash.now[:errors] = @post.errors.full_messages
	end
	redirect to ('/')
end