require 'test_helper'

class PostCommentsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student_user)
    @post = posts(:question6)
  end
  
  test "post interface" do
    log_in_as(@user)
    get new_post_comment_path(post_id: @post.id, user_id: @user.id, commented_user_id: @post.user.id)
    assert_select '#new-comment'
    assert_select 'ol.post-comments-stream-container'
    assert_select 'input[type=file]'
    # 無効な送信
    #assert_no_difference 'Post.count' do
    #  post posts_path, post: { status: "question", caption: "" }
    #end
    #assert_select 'div#error_explanation'
    # 有効な送信
    caption = "This post comment really ties the room together"
    assert_difference 'PostComment.count', 1 do
      post post_comments_path, post_comment: { status: "comment", caption: caption, post_id: @post.id, user_id: @user.id, commented_user_id: @post.user.id }
    end
    assert_redirected_to new_post_comment_path(post_id: @post.id)
    follow_redirect!
    assert_match caption, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_post_comment = @user.post_comments.paginate(page: 1).first
    assert_difference 'PostComment.count', -1 do
      delete post_comment_path(first_post_comment)
    end
  end
end
