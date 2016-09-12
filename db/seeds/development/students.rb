1.upto(10) do |idx|
  student = Student.create!(
    account_name: "student_account#{idx}",
    email: "student#{idx}@studish.org",
    password: "student#{idx}",
    password_confirmation: "student#{idx}",
    activated: true,
    activated_at: Time.zone.now,
  )
end