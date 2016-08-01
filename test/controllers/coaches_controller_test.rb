require 'test_helper'

class CoachesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "講師一覧 | Studish"
  end
  
end
