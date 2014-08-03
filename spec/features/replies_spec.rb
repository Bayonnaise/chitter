require 'spec_helper'
require_relative 'helpers/session'
include Helpers

feature "User replies" do
  before(:each) do
    User.create(:username => "First",
                :email => "first@email.com",
                :name => "First",
                :password => 'test',
                :password_confirmation => 'test')

    User.create(:username => "Second",
                :email => "second@email.com",
                :name => "Second",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "to first user's post" do
    sign_in("First", 'test')
    add_post("This is a test")
    @id = Post.last.id
    click_button("Sign out")
    sign_in("Second", 'test')
    click_link("Reply")
    fill_in 'reply-text', :with => "This is a reply"
    click_button('Reply')
    @post = Post.last
    expect(@post.text).to eq "This is a reply"
    expect(@post.reply_to_id).to eq @id
  end

end