require 'test_helper'

class CoachesSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Coach.count' do
      post coaches_path, coach: { name: "",
                                  email: "coach@invalid",
                                  password: "foo",
                                  password_confirmation: "bar" }
    end
    assert_template 'coaches/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Coach.count', 1 do
      post_via_redirect coaches_path, coach: { name: "test",
                                  full_name: "test",
                                  birthday: "1997-1-1",
                                  email: "test@test.com",
                                  university: "example university",
                                  major: "example major",
                                  subject: "example subject",
                                  school_year: "1年",
                                  self_introduction: "Hi.",
                                  password: "testpass",
                                  password_confirmation: "testpass",
                                  password_digest: "password_digest"
      }
    end
    assert_template 'welcome/index'
    assert_not_nil flash[:info]
  end
end
