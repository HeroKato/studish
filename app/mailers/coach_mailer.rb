class CoachMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coach_mailer.account_activation.subject
  #
  def account_activation(coach)
    @coach = coach
    mail to: coach.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coach_mailer.password_reset.subject
  #
  def password_reset(coach)
    @coach = coach
    mail to: coach.email, subject: "Password reset"
  end
end
