require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @coach = coaches(:axwell)
    remember(@coach)
  end
  
  test "current_coach returns right coach whne session is nil" do
    assert_equal @coach, current_coach
    assert is_logged_in?
  end
  
  test "correct_coach returns nil when remember digest is wrong" do
    @coach.update_attribute(:remember_digest, Coach.digest(Coach.new_token))
    assert_nil current_coach
  end
end