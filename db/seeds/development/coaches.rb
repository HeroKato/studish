names = %w(Hiro Ichiro Jiro Saburo Shiro Goro Rokuro Nanaro Hachiro Kuro)
fnames = ["加藤", "鈴木", "高橋", "田中"]
gnames = ["啓明", "太郎", "次郎"]
0.upto(9) do |idx|
  coach = Coach.create!(
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: "2016-7-9",
    university: "バカ田大学",
    major: "アホ学部マヌケ学科",
    school_year: "1年",
    subject: "英語",
    self_introduction: "Hi, I'm a idiot. Killing it!",
    administrator: (idx == 0),
    password: "password",
    password_confirmation: "password",
    password_digest: "password_digest"
  )
end