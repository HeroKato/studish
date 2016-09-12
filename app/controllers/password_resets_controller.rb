class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @coach = Coach.find_by(email: params[:password_reset][:email].downcase)
    @student = Student.find_by(email: params[:password_reset][:email].downcase)
    if @coach
      @coach.create_reset_digest
      @coach.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    elsif @student
      @student.create_reset_digest
      @student.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送りました。メールに記載されているリンクをクリックしてパスワードを再設定してください。"
      redirect_to root_url
    else
      flash[:danger] = "Email address not found"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @coach
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
    else
      if params[:student][:password].empty?
        @student.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @student.update_attributes(student_params)
        log_in @student
        flash[:success] = "Password has been reset."
        redirect_to @student
      else
        render 'edit'
      end
    end
  end
  
  private
  
    def coach_params
      params.require(:coach).permit(:password, :password_confirmation)
    end
    
    def student_params
      params.require(:student).permit(:password, :password_confirmation)
    end
  
    def get_user
      if @coach
        @coach = Coach.find_by(email: params[:email])
      else
        @student = Student.find_by(email: params[:email])
      end
    end
    
    # 正しいユーザを確認する
    def valid_user
      if @coach
        unless (@coach && @coach.activated? && @coach.authenticated?(:reset, params[:id]))
          redirect_to root_url
        end
      else
        unless (@student && @student.activated? && @student.authenticated?(:reset, params[:id]))
          redirect_to root_url
        end
      end
    end
    
    # 再設定用トークンが期限切れかどうかを確認する
    def check_expiration
      if @coach
        if @coach.password_reset_expired?
          flash[:danger] = "Password reset has expired."
          redirect_to new_password_reset_url
        end
      else
        if @student.password_reset_expired?
          flash[:danger] = "Password reset has expired."
          redirect_to new_password_reset_url
        end
      end
    end
end