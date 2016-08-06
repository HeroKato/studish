require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @coach = coaches(:axwell)
  end
  
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # メールアドレスが無効
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # メールアドレスが有効
    post password_resets_path, password_reset: { email: @coach.email }
    assert_not_equal @coach.reset_digest, @coach.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # パスワード再設定用フォーム
    coach = assigns(:coach)
    # メールアドレスが無効
    get edit_password_reset_path(coach.reset_token, email: "")
    assert_redirected_to root_url
    # 無効なコーチ
    coach.toggle!(:activated)
    get edit_password_reset_path(coach.reset_token, email: coach.email)
    assert_redirected_to root_url
    coach.toggle!(:activated)
    # メールアドレスが正しく、トークンが無効
    get edit_password_reset_path('wrong token', email: coach.email)
    assert_redirected_to root_url
    # メールアドレスもトークンも有効
    get edit_password_reset_path(coach.reset_token, email: coach.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", coach.email
    # 無効な新しいパスワードと新しいパスワードの確認
    patch password_reset_path(coach.reset_token),
      email: coach.email,
      coach: { password: "foobaz", password_confirmation: "foobbb" }
    assert_select 'div#error_explanation'
    assert_template 'password_resets/edit'
    # 新しいパスワードが空
    patch password_reset_path(coach.reset_token),
      email: coach.email,
      coach: { password: "", password_confirmation: "" }
    assert_select 'div#error_explanation'
    assert_template 'password_resets/edit'
    # 有効な新しいパスワードと新しいパスワードの確認
    patch password_reset_path(coach.reset_token),
      email: coach.email,
      coach: { password: "newtestpass", password_confirmation: "newtestpass" }
    assert is_logged_in? # なぞのfailuer
    assert_not flash.empty? # なぞのfailuer
    assert_redirected_to coach # なぞのfailuer
  end
end
