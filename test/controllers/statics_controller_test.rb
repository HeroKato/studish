require 'test_helper'

class StaticsControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Studish"
  end
  
  test "should get privacy" do
    get :privacy
    assert_response :success
    assert_select "title", "プライバシーポリシー | #{@base_title}"
  end
  
  test "should get terms" do
    get :terms
    assert_response :success
    assert_select "title", "利用規約 | #{@base_title}"
  end
  
end
