class AccountsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(account_params)
      flash[:success] = "Account Edit Success!"
      redirect_to :account
    else
      render "edit"
    end
  end
  
  private
  
  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation)
  end
  
end
