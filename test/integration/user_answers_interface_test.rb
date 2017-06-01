require 'test_helper'

class UserAnswersInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student_user)
    @user2 = users(:student_user2)
    @post = posts(:question1)
    @post2 = posts(:question6)
  end
  
  test "answers interface" do
    #ログインしてない状態でusers/:id/answersにアクセスする
    get answers_user_path(@user)
    assert_template :answers
    assert_select "a[href='/favorites']"
    assert_select "a[href='/post_comments/new?commented_user_id=#{@user2.id}&post_id=#{@post2.id}']"
    #ログイン後、外のユーザーのUsers/:id/answersにアクセスする
    log_in_as(@user2)
    get answers_user_path(@user)
    #ファボったpostが表示されている場合
    assert_select "a[href='/users/#{@user2.id}/posts/#{@post2.id}/favorites/#{@user2.favorites.find_by(post_id: @post2.id).id}']"
    #コメントしたpostが表示されている場合
    assert_select "a[href='/post_comments/new?commented_user_id=#{@user2.id}&post_id=#{@post2.id}&user_id=#{@user2.id}']"
  end
  
end