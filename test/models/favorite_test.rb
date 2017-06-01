require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:student_user)
    @post = posts(:question1)
    @favorite_for_post = Favorite.new(post_id: @post.id, user_id: @user.id, favorited_user_id: @post.user.id)
  end
  
  test "favorite_for_post should be valid" do
    assert @favorite_for_post.valid?
  end
  
  test "post_id should be present" do
    @favorite_for_post.post_id = ""
    assert @favorite_for_post.valid?
  end
  
  test "user_id should be present" do
    @favorite_for_post.user_id = ""
    assert_not @favorite_for_post.valid?
  end
  
  test "favorited_user_id should be present" do
    @favorite_for_post.favorited_user_id = ""
    assert_not @favorite_for_post.valid?
  end
  
end
