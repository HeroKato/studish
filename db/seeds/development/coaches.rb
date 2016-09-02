1.upto(100) do |idx|
  path = Rails.root.join("db/seeds/development/coach#{idx % 3 + 1}.jpg")
  coach = Coach.create!(
    name: "example#{idx}",
    account_name: "example_account#{idx}",
    email: "example#{idx}@studish.org",
    birthday: "2016-7-9",
    university: "バカ田大学",
    major: "アホ学部マヌケ学科",
    school_year: "1年",
    self_introduction: "Hi, I'm a idiot. Killing it!",
    administrator: (idx == 1),
    password: "password#{idx}",
    password_confirmation: "password#{idx}",
    activated: true,
    activated_at: Time.zone.now,
    picture: open("#{path}"),
    skype: "skype#{idx}",
    phone: "080-#{idx + 1000}-#{idx + 1000}",
  )
  CoachingSubject.create!(
    coach: coach,
    jr_english: '英語',
    jr_japanese: '国語'
  )
  CoachCertification.create!(
    coach: coach,
    eiken: '2級',
    toeic: '500',
  )
end