require 'test_helper'

class UserAccountTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student_user)
    @user2 = users(:student_user2)
  end
  
  test "account test" do
    #非ログイン状態でアカウントページへアクセス
    get account_path(@user)
    assert_redirected_to login_path
    #ログイン状態で他のユーザーのアカウントページへアクセス
    log_in_as(@user)
    get account_path(@user2)
    assert_redirected_to root_path
    #ログイン状態で自分のアカウントページへアクセス
    get account_path(@user)
    assert_template 'accounts/show'
    #ログイン状態で自分のアカウントの編集ページへアクセス
    get edit_account_path(@user)
    assert_template 'accounts/edit'
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_account_path(@user)
    assert_template 'accounts/edit'
    patch account_path(@user), account: { user_type: @user.user_type,
                                              name:  @user.name,
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" }
    assert_template 'accounts/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_account_path(@user)
    assert_template 'accounts/edit'
    patch account_path(@user), account: { user_type: @user.user_type,
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "foo" }
    assert_template 'accounts/edit'
  end
  
end