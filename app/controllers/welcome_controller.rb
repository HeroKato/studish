class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    @coach = Coach.find( Coach.pluck(:id).sample(7) ).sample(7)
  end
end
