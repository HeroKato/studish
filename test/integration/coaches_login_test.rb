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
    assert is_logged_in?
    assert_redirected_to @coach
    follow_redirect!
    assert_template 'coaches/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", coach_path(@coach)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", coaches_path
  end
  
  test "login with remembering" do
    log_in_as(@coach, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  
  test "login without remembering" do
    log_in_as(@coach, remember_me: '0')
    assert_nil cookies['remember_token']
  end
  
end
