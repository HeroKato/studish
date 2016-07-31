require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  test "factory girl" do
    coach = FactoryGirl.create(:coach)
    assert_equal "Leo Messi", coach.full_name
    assert_equal "アルゼンチン大学", coach.university
    assert_equal "フットボール学部サッカー学科", coach.major
    assert_equal "football,football,football", coach.subject
    assert_equal "3年", coach.school_year
    assert_equal "Hi, I'm Messi. I'm a professional football player. I'm playing in FC Barcelona. I was very short when I was young.", coach.self_introduction
    assert_equal "coach1.jpg", coach.picture
  end
  
  test "authenticate" do
    coach = FactoryGirl.create(:coach, name: "messi", picture: "coach1.jpg", password: "barcelona", password_confirmation: "barcelona")
    assert_nil Coach.authenticate("messi", "real")
    assert_equal coach, Coach.authenticate("messi", "barcelona")
  end
end
