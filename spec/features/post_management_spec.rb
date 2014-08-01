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

  scenario "when not signed in" do
    expect(Post.count).to eq(0)
    add_post("This is another test")
    expect(Post.count).to eq(0)
    expect(page).to have_content("Please log in")
  end

  def add_post(text)
    visit '/posts/new'
    fill_in 'text', :with => text
    click_button 'Post'
  end      
end