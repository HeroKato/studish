require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  
  
  
  def setup
    @coach = Coach.new(name: "test",
                      full_name: "test",
                      birthday: "1997-1-1",
                      email: "test@test.com",
                      university: "example university",
                      major: "example major",
                      school_year: "1年",
                      self_introduction: "Hi.",
                      password: "testpass",
                      password_confirmation: "testpass",
                      picture: Rack::Test::UploadedFile.new("app/assets/images/logo.png", "image/png"),
                      skype: "skypetest",
                      phone: "000-0000-0000"
                      )
  end
  
  test "should be valid" do
    assert @coach.valid?
  end
  
  test "name should be present" do
    @coach.name = ""
    assert_not @coach.valid?
  end
  
  test "email should be present" do
    @coach.email = ""
    assert_not @coach.valid?
  end
  
  test "name should not be too long" do
    @coach.name = "a"*51
    assert_not @coach.valid?
  end
  
  test "email should not be too long" do
    @coach.email = "a"*244 + "@example.com"
    assert_not @coach.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[coach@example.com COACH@foo.COM A_COA_CH@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @coach.email = valid_address
      assert @coach.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[coach@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @coach.email = invalid_address
      assert_not @coach.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_coach = @coach.dup
    duplicate_coach.email = @coach.email.upcase
    @coach.save
    assert_not duplicate_coach.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "coAch@ExAmplE.CoM"
    @coach.email = mixed_case_email
    @coach.save
    assert_equal mixed_case_email.downcase, @coach.reload.email
  end
  
  test "password should be present(nonblank)" do
    @coach.password = @coach.password_confirmation = "" *6
    assert_not @coach.valid?
  end
  
  test "password should have a minimum length" do
    @coach.password = @coach.password_confirmation = "a" *7
    assert_not @coach.valid?
  end
  
  test "authenticated? should return false for a coach with nil digest" do
    assert_not @coach.authenticated?(:remember,'')
  end

end
