class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :favorites]
  before_action :correct_user_2, only: [:edit]
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    if @user.user_type == "student"
      @questions_count = @user.posts.where(status: "question").count
      @notes_count = @user.posts.where(status: "note").count
      @answers_count = @user.post_comments.where(status: "answer").count
      @favorites_count = @user.favorites.count
      render "show_student"
    elsif @user.user_type == "coach"
      @answers_count = @user.post_comments.where(status: "answer").count
      @favorites_count = @user.favorites.count
      @reports_count = @user.posts.where(status: "report").count
      render "show_coach"
    end
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
