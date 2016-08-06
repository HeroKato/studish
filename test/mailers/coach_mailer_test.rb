require 'test_helper'

class CoachMailerTest < ActionMailer::TestCase

  test "account_activation" do
    coach = coaches(:axwell)
    coach.activation_token = Coach.new_token
    mail = CoachMailer.account_activation(coach)
    assert_equal "Account activation", mail.subject
    assert_equal [coach.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match coach.name, mail.body.encoded
    assert_match coach.activation_token, mail.body.encoded
    assert_match CGI::escape(coach.email), mail.body.encoded
  end
  
  test "password_reset" do
    coach = coaches(:axwell)
    coach.reset_token = Coach.new_token
    mail = CoachMailer.password_reset(coach)
    assert_equal "Password reset", mail.subject
    assert_equal [coach.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match coach.name, mail.body.encoded
    assert_match coach.reset_token, mail.body.encoded
    assert_match CGI::escape(coach.email), mail.body.encoded
  end
  
end
