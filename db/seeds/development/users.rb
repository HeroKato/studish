1.upto(5) do |idx|
  path = Rails.root.join("db/seeds/development/coach#{idx % 5 + 1}.jpg")
  user = User.create!(
    user_type: "coach",
    name: "coach#{idx}",
    account_name: "coach_account#{idx}",
    email: "coach#{idx}@studish.org",
    avatar: open("#{path}"),
    self_introduction: "Hi, I'm a idiot. Killing it!",
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now,
    deleted: false,
    suspended: false
  )
  ExpandedCoachProfile.create!(
    university: "バカ田大学",
    major: "アホ学部マヌケ学科",
    school_year: "1年",
    skype: "skype#{idx}",
  )
  CoachingSubject.create!(
    user: user,
    jr_english: '英語',
    jr_japanese: '国語'
  )
  CoachCertification.create!(
    user: user,
    eiken: '2級',
    toeic: '500',
  )
end

1.upto(5) do |idx|
  path = Rails.root.join("db/seeds/development/coach#{idx % 5 + 1}.jpg")
  User.create!(
    user_type: "student",
    name: "student#{idx}",
    account_name: "student_account#{idx}",
    email: "student#{idx}@studish.org",
    avatar: open("#{path}"),
    self_introduction: "Hi, I'm a idiot. Killing it!",
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now,
    deleted: false,
    suspended: false
    )
end