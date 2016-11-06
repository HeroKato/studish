path = Rails.root.join("db/seeds/staging/coach1.jpg")
coach = Coach.create!(
  name: "admin",
  account_name: "admin_account",
  email: "admin@studish.com",
  avatar: open("#{path}"),
  birthday: "2016-7-9",
  university: "バカ田大学",
  major: "アホ学部マヌケ学科",
  school_year: "1年",
  self_introduction: "Hi, I'm a idiot. Killing it!",
  skype: "adminskype",
  phone: "123-1234-5678",
  administrator: "true",
  password: "adminpass",
  password_confirmation: "adminpass",
  activated: true,
  activated_at: Time.zone.now,
  deleted: false,
  suspended: false
)
CoachingSubject.create!(
  coach: coach,
  jr_english: '英語',
  jr_japanese: '国語'
)
CoachCertification.create!(
  coach: coach,
  eiken: '2級',
  toeic: '500'
)