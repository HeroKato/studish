require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid coach signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { user_type: "coach",
                                         account_name:  "",
                                         email: "coach_user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "invalid student signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { user_type: "student",
                                         account_name:  "",
                                         email: "student_user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "valid coach signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { user_type: "coach",
                               account_name:  "ExampleCoachUser",
                               email: "coach_user@example.com",
                               password:              "coach_password",
                               password_confirmation: "coach_password" } 
    end
    follow_redirect!
    assert_template 'welcome/index'
    assert_not flash.empty?
  end
  
  test "valid student signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { user_type: "student",
                               account_name:  "ExampleStudentUser",
                               email: "student_user@example.com",
                               password:              "student_password",
                               password_confirmation: "student_password" } 
    end
    follow_redirect!
    assert_template 'welcome/index'
    assert_not flash.empty?
  end
  
  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { user_type: "coach", account_name:  "ExampleUser",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  
end