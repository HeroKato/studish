# Preview all emails at http://localhost:3000/rails/mailers/coach_mailer
class CoachMailerPreview < ActionMailer::Preview

  # Preview this email at http://studish-herokato.c9users.io/rails/mailers/coach_mailer/account_activation
  def account_activation
    coach = Coach.first
    coach.activation_token = Coach.new_token
    CoachMailer.account_activation(coach)
  end

  # Preview this email at http://localhost:3000/rails/mailers/coach_mailer/password_reset
  def password_reset
    CoachMailer.password_reset
  end

end
