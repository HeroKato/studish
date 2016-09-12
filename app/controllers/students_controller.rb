class StudentsController < ApplicationController
  before_action :logged_in_student, only: [:edit, :update, :destroy]
  before_action :correct_student, only: [:edit, :upddate, :destroy]
  
  def show
    @student = Student.find(params[:id])
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
      flash[:success] = "Profile Edit Success!"
      redirect_to @student
    else
      render "edit"
    end
  end
  
  private
  
  def student_params
    params.require(:student).permit(:account_name, :name, :email, :self_introduction, :password, :password_confirmation)
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
end
