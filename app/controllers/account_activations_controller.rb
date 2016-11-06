class AccountActivationsController < ApplicationController
  
  def edit
    user = Coach.find_by(email: params[:email])
    
    if user == nil
      user = Student.find_by(email: params[:email])
    end
    
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account Activated! Please Update Your Profile and Account imformation."
      redirect_to user
    else
      flash[:danger] = "Invalid Activation Link"
      redirect_to root_url
    end
    #coach = Coach.find_by(email: params[:email])
    #if coach && !coach.activated? && coach.authenticated?(:activation, params[:id])
    #  coach.activate
    #  log_in coach
    #  flash[:success] = "Account Activated! Please Update Your Profile and Account imformation."
    #  redirect_to coach
    #else
    #  flash[:danger] = "Invalid Activation Link"
    #  redirect_to root_url
    #end
  end
end
