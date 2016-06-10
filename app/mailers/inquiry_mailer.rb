class InquiryMailer < ActionMailer::Base
  default to: "studish.info@gmail.com" 
  default from: "example@example.com"

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:subject => '無料体験申込みフォームから申込がありました。')
  end

end