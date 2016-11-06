1.upto(100) do |idx|
  path = Rails.root.join("db/seeds/development/coach#{idx % 5 + 1}.jpg")
  coach = Coach.create!(
    name: "coach#{idx}",
    account_name: "coach_account#{idx}",
    email: "coach#{idx}@studish.org",
    avatar: open("#{path}"),
    birthday: "2016-7-9",
    university: "バカ田大学",
    major: "アホ学部マヌケ学科",
    school_year: "1年",
    self_introduction: "Hi, I'm a idiot. Killing it!",
    skype: "skype#{idx}",
    phone: "080-#{idx + 1000}-#{idx + 1000}",
    administrator: (idx == 1),
    password: "coachpass#{idx}",
    password_confirmation: "coachpass#{idx}",
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
    toeic: '500',
  )
end