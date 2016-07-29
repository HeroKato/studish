require 'test_helper'

class CoachMailerTest < ActionMailer::TestCase
  test "account_activation" do
    coach = Coach.ids(1)
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
    mail = CoachMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
