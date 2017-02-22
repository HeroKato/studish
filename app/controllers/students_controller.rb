class StudentsController < ApplicationController
  before_action :logged_in_student, only: [:edit, :update, :destroy]
  before_action :correct_student, only: [:edit, :upddate, :destroy, :account, :notifications]
  before_action :logged_in_user, only: [:show, :favorites]
  before_action :student_profile_check, only: [:show, :favorites]
  after_action :save_flags, only: [:notifications]
  
  def show
    @student = Student.find(params[:id])
    @posts = @student.posts.page(params[:page]).per_page(10)
    @questions_count = @student.posts.where(status: "question").count
    @notes_count = @student.posts.where(status: "note").count
  end
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params)
    if @student.save
      @student.send_activation_email
      flash[:info] = "登録したメールアドレスにメールを送りました。送られてきたメールのリンクにアクセスしてアカウントを有効化してください。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    @student.assign_attributes(student_params)
    if  @student.save(context: :normal_update)
      flash[:success] = "Edit Success!"
      redirect_to @student
    else
      render "edit"
    end
  end
  
  def account
    @student = Student.find(params[:id])
  end
  
  def favorites
    @student = Student.find(params[:id])
    @favorites = @student.favorites.order("created_at DESC")
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page]).per(10)
    #@reports = @coach.favorited_reports.order("favorites.created_at DESC")
    #@reports = Kaminari.paginate_array(@reports).page(params[:page]).per(5)
    @template = "favorites"
  end
  
  def answers
    @student = Student.find(params[:id])
    @answers = @student.post_comments.where(status: "answer").order("created_at DESC")
    @answers = Kaminari.paginate_array(@answers).page(params[:page]).per(10)
  end
    
  def notifications
    @favorited = Favorite.where(favorited_student_id: current_student.id)
    @commented = PostComment.where(commented_student_id: current_student.id)
    @notifications = @commented.push(@favorited)
    @notifications.flatten!
    @notifications = @notifications.sort_by{ |n| n.created_at }
    @notifications = @notifications.reverse
    @notifications = Kaminari.paginate_array(@notifications).page(params[:page]).per(5)
  end  
  
  private
  
  def student_params
    params.require(:student).permit(:account_name, :name, :email, :self_introduction, :avatar, :avatar_cache, :password, :password_confirmation)
  end
  
  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token = Student.new_token
    self.activation_digest = Student.digest(activation_token)
  end
  
  def correct_student
    @student = Student.find(params[:id])
    unless current_student?(@student)
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end
  
  def student_profile_check
    @student = Student.find(params[:id])
    unless @student == current_student
      if (@student.avatar.url == nil) || (@student.name == "no_name")
        flash[:info] = "お探しのアカウントは非公開になっています"
        redirect_to root_url
      end
    end
  end
end
