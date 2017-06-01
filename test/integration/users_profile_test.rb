require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:student_user)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'img.avatar'
    assert_match @user.posts.count.to_s, response.body
    assert_select 'ol.post-stream-container'
  end
end