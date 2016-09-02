class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    @coaches = Coach.where(activated: true).full_profile.pluck(:id).sample(6).sample(6)
  end
end