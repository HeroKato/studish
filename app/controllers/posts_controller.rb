class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :logged_in_student, only: [:new, :create]
  before_action :correct_student2, only: [:edit, :update, :destroy]
  before_action :profile_check, only: [:new, :create]
  
  def index
    @posts = Post.all.page(params[:page]).per_page(10)
  end
  
  def show
  end
  
  def new
    @post = Post.new
    2.times { @post.post_pictures.build }
  end
  
  def create
    @post = current_student.posts.build(post_params)
    if @post.save
      flash[:success] = "クエスチョンを投稿しました！"
      redirect_to :posts
    else
      @post.post_pictures.build
      render 'new'
    end
  end
  
  def edit
    @post = current_student.posts.find(params[:id])
    unless @post.post_pictures.present?
      @post_pictures = @post.post_pictures.build
    end
  end
  
  def update
    @post = current_student.posts.find(params[:id])
    if @post.update_attributes(update_post_params)
      flash[:success] = "ポストを更新しました。"
      redirect_to :posts
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = current_student.posts.find(params[:id])
    @post.destroy
    flash[:success] = "ポストを削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:caption, :subject, :text_name, :chapter, :section,
                                 :page, :number, :pattern, { post_pictures_attributes: [:pictures] })
  end
  
  def update_post_params
    params.require(:post).permit(:caption,:subject, :text_name, :chapter, :section,
                                 :page, :number, :pattern, { post_pictures_attributes: [:id, :pictures] })
  end
  
  def profile_check
    if logged_in_as_student?
      if (current_student.name == "no_name") || current_student.avatar.url.nil?
        flash[:info] = "プロフィール情報（nameとavatar）を更新してみんなにクエスチョン（質問）してみよう！"
        redirect_to current_student
      end
    end
  end
  
  def correct_student2
    post = Post.find(params[:id])
    student = post.student
    unless current_student?(student)
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end
  
end