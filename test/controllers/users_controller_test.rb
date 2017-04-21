require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should get new for student" do
    get :new
    assert_response :success
  end
  
end
