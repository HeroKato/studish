path = Rails.root.join("db/seeds/staging/coach1.jpg")
coach = Coach.create!(
  name: "admin",
  full_name: "admin",
  email: "admin@studish.com",
  birthday: "2016-7-9",
  university: "バカ田大学",
  major: "アホ学部マヌケ学科",
  school_year: "1年",
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
CoachingSubject.create!(
  coach: coach,
  jr_english: '英語',
  jr_japanese: '国語',
  jr_math: '',
  jr_science: '',
  jr_social: ''
)
CoachCertification.create!(
  coach: coach,
  eiken: '2級',
  toeic: '500',
  toefl: '60',
  ielts: '5.5',
  kanken: '2級',
  suuken: '2級'
)