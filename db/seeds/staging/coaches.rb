Coach.create!(
  name: "admin",
  full_name: "admin",
  email: "admin@studish.com",
  birthday: "2016-7-9",
  university: "バカ田大学",
  major: "アホ学部マヌケ学科",
  school_year: "1年",
  subject: "英語",
  self_introduction: "Hi, I'm a idiot. Killing it!",
  administrator: "true",
  password: "adminpass",
  password_confirmation: "adminpass",
  activated: true,
  activated_at: Time.zone.now,
  picture: open("#{path}"),
  skype: "adminskype",
  phone: "123-1234-5678"
)