require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:coach_user)
    @other_user = users(:coach_messi)
  end
  
  test "should get new for user" do
    get :new, user_type: "coach"
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user.id
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user.id, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user.id
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user.id, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user.id
    end
    assert_redirected_to login_url
  end
  
end
