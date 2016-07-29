class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    coach = Coach.find_by(email: params[:session][:email].downcase)
    if coach && coach.authenticate(params[:session][:password])
      if coach.activated?
        log_in coach
        params[:session][:remember_me] == '1' ? remember(coach):forget(coach)
        redirect_back_or coach
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:info] = "logged out!"
    redirect_to root_path
  end
  
end
