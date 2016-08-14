fnames = ["加藤", "鈴木", "高橋", "田中"]
gnames = ["啓明", "太郎", "次郎"]
1.upto(100) do |idx|
  path = Rails.root.join("db/seeds/development/coach#{idx % 3 + 1}.jpg")
  coach = Coach.create!(
    name: "example#{idx}",
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "example#{idx}@studish.org",
    birthday: "2016-7-9",
    university: "バカ田大学",
    major: "アホ学部マヌケ学科",
    school_year: "1年",
    self_introduction: "Hi, I'm a idiot. Killing it!",
    administrator: (idx == 1),
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now,
    picture: open("#{path}"),
    skype: "skype#{idx}",
    phone: "080-#{idx + 1000}-#{idx + 1000}",
  )
  CoachingSubject.create!(
    coach: coach,
    jr_english: '英語',
    jr_japanese: '国語',
    jr_math: '',
    jr_science: '',
    jr_social: ''
  )
end