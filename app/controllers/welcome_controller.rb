class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
    @slide = Coach.find( Coach.pluck(:id).sample(7) ).sample(7)
  end
end
