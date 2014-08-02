require 'spec_helper'

feature "User adds a new post" do
  before(:each) do
    User.create(:username => "Davetest",
                :email => "dave@email.com",
                :name => "Dave",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "when signed in" do
    sign_in("Davetest", 'test')
    expect(Post.count).to eq(0)
    add_post("This is a test")
    expect(Post.count).to eq(1)
    post = Post.first
    expect(post.text).to eq("This is a test")
    expect(post.timestamp).to be_kind_of(Time)
  end

  scenario "that's 140 characters" do
    sign_in("Davetest", 'test')
    expect(Post.count).to eq(0)
    add_post("TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest")
    expect(Post.count).to eq(1)
  end

  def add_post(text)
    fill_in 'post-content', :with => text
    click_button 'Post'
  end      
end