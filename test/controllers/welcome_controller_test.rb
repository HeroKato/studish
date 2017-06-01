require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Studish"
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Top | #{@base_title}"
    assert_select 'header'
  end

end