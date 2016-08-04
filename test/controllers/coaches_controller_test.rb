require 'test_helper'

class CoachesControllerTest < ActionController::TestCase
  
  def setup
    @coach = coaches(:axwell)
    @other_coach = coaches(:ingrosso)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "講師一覧 | Studish"
  end
  
  test "should render coaches/index whether logged in or not" do
    get :index
    assert_template 'coaches/index'
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @coach
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch :update, id: @coach, coach: { name: @coach.name, email: @coach.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong coach" do
    log_in_as(@other_coach)
    get :edit, id: @coach
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong coach" do
    log_in_as(@other_coach)
    patch :update, id: @coach, coach: { name: @coach.name, email: @coach.email }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
end
