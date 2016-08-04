ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # テストコーチがログインしていればtrueを返す
  def is_logged_in?
    !session[:coach_id].nil?
  end
  
  # テストコーチとしてログインする
  def log_in_as(coach, options = {})
    password = options[:password]||'password'
    remember_me = options[:remember_me]||'1'
    if integration_test?
      post login_path, session: { email: coach.email,
                                  password: password,
                                  remember_me: remember_me }
    else
      session[:coach_id] = coach.id
    end
  end
  
  
  private
  
  # 統合テスト内ではtrueを返す
  def integration_test?
    defined?(post_via_redirect)
  end
  
end
