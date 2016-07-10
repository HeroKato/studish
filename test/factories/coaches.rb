FactoryGirl.define do
  factory :coach do
    sequence(:name) { |n| "Messi#{n}" }
    full_name "Leo Messi"
    sequence(:email) { |n| "messi#{n}@example.com" }
    birthday 29.years.ago
    university "アルゼンチン大学"
    major "フットボール学部サッカー学科"
    school_year "3年"
    subject "football,football,football"
    self_introduction "Hi, I'm Messi. I'm a professional football player. I'm playing in FC Barcelona. I was very short when I was young."
    password "password"
    password_confirmation "password"
  end
end