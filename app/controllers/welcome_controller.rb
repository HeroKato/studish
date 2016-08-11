class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    coach = Coach.where(activated: true)
    @slide_coaches = coach.find( coach.pluck(:id).sample(7) ).sample(7)
  end
end