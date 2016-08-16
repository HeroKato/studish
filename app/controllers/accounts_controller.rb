class AccountsController < ApplicationController
  before_action :logged_in_coach
  
  def show
    @coach = current_coach
  end

  def edit
    @coach = current_coach
  end
  
  def update
    @coach = current_coach
    if @coach.update_attributes(account_params)
      flash[:success] = "Account Edit Success!"
      redirect_to :account
    else
      render "edit"
    end
  end
  
  private
  
  def account_params
    params.require(:account).permit(:full_name, :birthday, :email, :phone, :skype, :password, :password_confirmation)
  end
  
end
