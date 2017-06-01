require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:coach_user)
  end

  test "unsuccessful edit" do
    post login_path, session: { email: @user.email, password: 'password' }
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { user_type: @user.user_type,
                                              name:  @user.name,
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" }

    assert_template 'users/edit'
  end
  
  test "successful edit" do
    post login_path, session: { email: @user.email, password: 'password' }
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "FooBar", password: "password", password_confirmation: "password" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "FooBar",  @user.name
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    patch user_path(@user), user: { name: "FooBar", password: "password", password_confirmation: "password" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "FooBar",  @user.name
  end
end
