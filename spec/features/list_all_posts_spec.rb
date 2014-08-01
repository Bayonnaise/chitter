require 'spec_helper'

feature "User browses a list of posts" do
	
	before(:each) {
		Post.create(:text => "This is a test.",
								:timestamp => Time.now,
								:user_id => "1")
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Chitter")
	end

end