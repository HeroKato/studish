require 'test_helper'

class UserFavoritesInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student_user)
    @post = posts(:question1)
    @user2 = users(:student_user2)
    @post2 = posts(:question6)
    @favorite3 = favorites(:favorite3)
  end
  
  test "favorites interface" do
    #ログインしてない状態でusers/:id/favoritesにアクセスする
    get favorites_user_path(@user)
    assert_template :favorites
    assert_select "div.favorite-stream-container"
    assert_select "li.favorite"
    assert_select "a[href='/favorites']"
    assert_select "a[href='/post_comments/new?commented_user_id=#{@user2.id}&post_id=#{@post2.id}']"
    #ログインしている状態で、他ユーザーのUsers/:id/favoritesにアクセスする
    log_in_as(@user2)
    get favorites_user_path(@user)
    #favったpostが表示されてる場合
    assert_select "i.fa.fa-heart.action-button.favorited"
    assert_select "a[data-method=delete]"
    assert_select "a[href='/users/#{@user2.id}/posts/#{@post2.id}/favorites/#{@user2.favorites.find_by(post_id: @post2.id).id}']"
    #コメントしたpostが表示されている場合
    assert_select "a[href='/post_comments/new?commented_user_id=#{@user2.id}&post_id=#{@post2.id}&user_id=#{@user2.id}']"
  end
end
