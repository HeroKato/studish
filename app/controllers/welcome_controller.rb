class WelcomeController < ApplicationController
  def index
    @inquiry = Inquiry.new
  end
end
