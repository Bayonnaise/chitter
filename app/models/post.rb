class Post

	include DataMapper::Resource

	property :id, Serial
	property :timestamp, Time
	property :text, String, :required => true

	belongs_to :user

end