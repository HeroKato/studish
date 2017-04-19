class UsersController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def new
    if params[:user_type]
      unless logged_in_user?
        @user = User.new
      else
        flash[:danger] = "Please log out before creating a new coach account."
        redirect_to root_path
      end
    else
      flash[:danger] = "当該ページへのアクセスが拒否されました。"
      redirect_to root_path
    end
  end
  
  def create
    @user = User.new(create_user_params)
    if @user.user_type = 'coach'
      @user.subjects = CoachingSubject.new(subjects_params)
      @user.certifications = CoachCertification.new(certifications_params)
    end
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def create_user_params
    params.require(:user).permit(:user_type, :account_name, :email, :password, :password_confirmation)
  end
  
  def logged_in_user?
    !!current_user
  end
  
end
