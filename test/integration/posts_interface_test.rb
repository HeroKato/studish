require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student_user)
  end

  test "post interface" do
    log_in_as(@user)
    get posts_path
    assert_select 'nav.pagination'
    get question_path(status: "question")
    assert_select 'input[type=file]'
    # 無効な送信
    #assert_no_difference 'Post.count' do
    #  post posts_path, post: { status: "question", caption: "" }
    #end
    #assert_select 'div#error_explanation'
    # 有効な送信
    caption = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post posts_path, post: { status: "question", subject: "勉強方法", caption: caption }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_match caption, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:student_user2))
    assert_select 'a', text: '削除', count: 0
  end
end
