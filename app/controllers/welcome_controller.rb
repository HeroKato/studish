class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    coach = Coach.where(activated: true)
    @coaches = coach.full_profile.find( coach.pluck(:id).sample(6) ).sample(6)
  end
end