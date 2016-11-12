sentence =
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test."
1.upto(3) do |idx|
  path1 = Rails.root.join("db/seeds/development/coach#{idx}.jpg")
  student = Student.create!(
    account_name: "student_account#{idx}",
    name: "student_name#{idx}",
    email: "student#{idx}@studish.org",
    self_introduction: sentence,
    avatar: open("#{path1}"),
    password: "student#{idx}",
    password_confirmation: "student#{idx}",
    activated: true,
    activated_at: Time.zone.now,
    deleted: false,
    suspended: false
  )
end
students = Student.order(:created_at).take(3)
path2 = Rails.root.join("db/seeds/development/note.jpg")
2.times do
  caption = Faker::Lorem.sentence(5)
  students.each { |student| 
    post = student.posts.create!(
      caption: caption,
      subject: "数1A",
      text_name: "青チャ1A",
      number: "基本例題100"
    )
    post.post_pictures.create!(
      pictures: open("#{path2}")
    )
  }
end