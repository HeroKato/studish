require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", coaches_path
  end
end
