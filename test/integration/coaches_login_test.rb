require 'test_helper'

class CoachesLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @coach = coaches(:axwell)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @coach.email, password: "password" }
    assert_redirected_to @coach
    follow_redirect!
    assert_template 'coaches/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", coach_path(@coach)
  end
  
end
