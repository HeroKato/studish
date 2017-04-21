require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", "#line"
    assert_select "a[href=?]", "#plan"
    assert_select "a[href=?]", inquiry_path
  end
end
