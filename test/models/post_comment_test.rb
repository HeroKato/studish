require 'test_helper'

class PostCommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:student_user)
    @post = posts(:question6)
    @post_comment = @user.post_comments.build(caption: "caption", user_id: @user.id, post_id: @post.id, commented_user_id: @post.user.id)
  end
  
  test "should be valid" do
    assert @post_comment.valid?
  end

  test "user id should be present" do
    @post_comment.user_id = nil
    assert_not @post_comment.valid?
  end
  
  test "caption should be present" do
    @post_comment.caption = "   "
    assert_not @post_comment.valid?
  end

  test "caption should be at most 1000 characters" do
    @post_comment.caption = "a" * 1001
    assert_not @post_comment.valid?
  end
  
  test "post id should be present" do
    @post_comment.post_id = ""
    assert_not @post_comment.valid?
  end
  
  test "commented_user_id should be present" do
    @post_comment.commented_user_id = ""
    assert_not @post_comment.valid?
  end

end
