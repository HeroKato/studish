require 'test_helper'

class CoachesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @coach = coaches(:axwell)
  end
  
  test "unsuccessful edit" do
    log_in_as(@coach)
    get edit_coach_path(@coach)
    assert_template 'coaches/edit'
    patch coach_path(@coach), coach: { name: "",
                                      email: "foo@invalid",
                                      password: "foo",
                                      password_confirmation: "bar" }
    assert_template 'coaches/edit'
  end
  
  test "successful edit with friendly forwarding" do
    get edit_coach_path(@coach)
    log_in_as(@coach)
    assert_redirected_to edit_coach_path(@coach)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch coach_path(@coach), coach: { name: name,
                                      email: email,
                                      password: "",
                                      password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @coach
    @coach.reload
    assert_equal name, @coach.name
    assert_equal email, @coach.email
  end
end
