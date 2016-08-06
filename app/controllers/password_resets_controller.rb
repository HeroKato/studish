class PasswordResetsController < ApplicationController
  before_action :get_coach, only: [:edit, :update]
  before_action :valid_coach, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @coach = Coach.find_by(email: params[:password_reset][:email].downcase)
    if @coach
      @coach.create_reset_digest
      @coach.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash[:danger] = "Email address not found"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if params[:coach][:password].empty?
      @coach.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @coach.update_attributes(coach_params)
      log_in @coach
      flash[:success] = "Password has been reset."
      redirect_to @coach
    else
      render 'edit'
    end
  end
  
  private
  
    def coach_params
      params.require(:coach).permit(:password, :password_confirmation)
    end
  
    def get_coach
      @coach = Coach.find_by(email: params[:email])
    end
    
    # 正しいコーチを確認する
    def valid_coach
      unless (@coach && @coach.activated? && @coach.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # 再設定用トークンが期限切れかどうかを確認する
    def check_expiration
      if @coach.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end