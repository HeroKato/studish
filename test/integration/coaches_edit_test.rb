require 'test_helper'

class CoachesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @coach = coaches(:axwell)
  end
  
  test "unsuccessful edit" do
    log_in_as(@coach)
    get edit_coach_path(@coach)
    assert_template 'coaches/edit'
    patch coach_path(@coach), coach: { name: "Axwell Example",
                                      full_name: "Axwell full",
                                      email: "axwell@example.com",
                                      birthday: "1997-1-1",
                                      university: "test university",
                                      major: "test major",
                                      school_year: "1年",
                                      subject: "test subject",
                                      self_introduction: "hi.",
                                      picture: Rack::Test::UploadedFile.new("app/assets/images/logo.png", "image/png"),
                                      password: "",
                                      password_confirmation: "",
                                      skype: "axwellskype2",
                                      phone: "080-1111-1111" }
    assert_template 'coaches/edit'
  end
  
  test "successful edit with friendly forwarding" do
    get edit_coach_path(@coach)
    log_in_as(@coach)
    assert_redirected_to edit_coach_path(@coach)
    patch coach_path(@coach), coach: { name: "Foo Bar",
                                      full_name: "Axwell full",
                                      email: "foo@bar.com",
                                      birthday: "1997-1-1",
                                      university: "test university",
                                      major: "test major",
                                      school_year: "1年",
                                      self_introduction: "hi.",
                                      picture: Rack::Test::UploadedFile.new("app/assets/images/logo.png", "image/png"),
                                      password: "",
                                      password_confirmation: "",
                                      skype: "axwellskype2",
                                      phone: "080-1111-1111" }
    assert_not flash.empty?
    assert_template 'coaches/show'
    @coach.reload
    assert_equal name, @coach.name
    assert_equal email, @coach.email
  end
end
