require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
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
  
end