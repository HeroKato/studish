require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:coach_user)
    @post = @user.posts.build(caption: "caption", subject: "数1")
  end
  
  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "caption should be present" do
    @post.caption = "   "
    assert_not @post.valid?
  end

  test "caption should be at most 1000 characters" do
    @post.caption = "a" * 1001
    assert_not @post.valid?
  end
  
  test "subject should be present" do
    @post.subject = ""
    assert_not @post.valid?
  end
  
  test "subject should be at most 20 characters" do
    @post.subject = "a" * 21
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
