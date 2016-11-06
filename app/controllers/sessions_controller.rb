class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = Coach.find_by(email: params[:session][:email].downcase)
    if user.nil?
      user = Student.find_by(email: params[:session][:email].downcase)
    end
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user):forget(user)
        redirect_to user
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
    #if user && coach.authenticate(params[:session][:password])
    #  if coach.activated?
    #    log_in coach
    #    params[:session][:remember_me] == '1' ? remember(coach):forget(coach)
    #    redirect_back_or coach
    #  else
    #    message = "Account not activated."
    #    message += "Check your email for the activation link."
    #    flash[:warning] = message
    #    redirect_to root_url
    #  end
    #else
    #  flash.now[:danger] = 'invalid email/password combination'
    #  render 'new'
    #end
  end
  
  def destroy
    log_out if logged_in_as_coach? || logged_in_as_student?
    flash[:info] = "logged out!"
    redirect_to root_path
  end
  
end
