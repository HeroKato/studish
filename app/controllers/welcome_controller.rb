class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    coach_ids = Coach.where(activated: true).full_profile.pluck(:id).sample(6).sample(6)
    @coaches = Coach.where(id: coach_ids)
  end
end