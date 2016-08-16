require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get ahow" do
    get :ahow
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

end
