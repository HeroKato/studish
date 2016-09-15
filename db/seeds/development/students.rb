sentence =
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test."+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test.\n"+
  "this is a test.this is a test.this is a test."
1.upto(10) do |idx|
  path1 = Rails.root.join("db/seeds/development/coach#{idx % 5 + 1}.jpg")
  student = Student.create!(
    account_name: "student_account#{idx}",
    name: "student_name#{idx}",
    email: "student#{idx}@studish.org",
    self_introduction: sentence,
    profile_picture: open("#{path1}"),
    password: "student#{idx}",
    password_confirmation: "student#{idx}",
    activated: true,
    activated_at: Time.zone.now,
  )
end
students = Student.order(:created_at).take(6)
path2 = Rails.root.join("db/seeds/development/note.jpg")
10.times do
  caption = Faker::Lorem.sentence(5)
  students.each { |student| 
    post = student.posts.create!(
      caption: caption
    )
    post.post_pictures.create!(
      pictures: open("#{path2}")
    )
  }
end