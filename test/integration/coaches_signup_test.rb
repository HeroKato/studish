require 'test_helper'

class CoachesSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
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
  
  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Coach.count', 1 do
      post coaches_path, coach: { name: "test",
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
                                  password_digest: "password_digest",
                                  picture: Rack::Test::UploadedFile.new("app/assets/images/logo.png", "image/png") }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    coach = assigns(:coach)
    assert_not coach.activated?
    # 有効化してない状態でログインしてみる
    log_in_as(coach)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(coach.activation_token, email: "wrong")
    assert_not is_logged_in?
    # 有効化トークンとメールアドレスが正しい場合
    get edit_account_activation_path(coach.activation_token, email: coach.email)
    assert coach.reload.activated?
    follow_redirect!
    assert_template 'coaches/show'
    assert is_logged_in?
  end
end
