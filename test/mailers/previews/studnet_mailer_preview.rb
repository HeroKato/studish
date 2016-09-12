# Preview all emails at http://localhost:3000/rails/mailers/studnet_mailer
class StudnetMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/studnet_mailer/account_activation
  def account_activation
    StudnetMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/studnet_mailer/password_reset
  def password_reset
    StudnetMailer.password_reset
  end

end
