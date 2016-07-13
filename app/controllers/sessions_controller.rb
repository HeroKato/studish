class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @coach = Coach.find_by(email: params[:session][:email].downcase)
    if @coach && @coach.authenticate(params[:session][:password])
      session[:coach_id] = @coach.id
      flash[:info] = "logged in as #{@coach.name}"
      params[:session][:remember_me] == '1' ? remember(@coach):forget(@coach)
      remember @coach
      redirect_to @coach
    else
      flash[:denger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:info] = "logged out!"
    redirect_to root_path
  end
  
end
