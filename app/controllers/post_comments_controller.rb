class PostCommentsController < ApplicationController
  attr_accessor :post_id
  before_action :logged_in_user, only: [:create]
  before_action :correct_user2, only: [:edit, :update, :destroy]
  before_action :profile_check, only: [:new, :create]
  after_action :save_flags, only: [:new]
  
  def index
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
  end
  
  def new
    @comment = PostComment.new
    @comment.comment_pictures.build
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(10)
    @twitter_title = @post.subject
    @twitter_discription = @comments.first.caption
    @twitter_image_url = @comments.first.comment_pictures.medium.url
    
    if logged_in_as_student?
      if @post.student_id == current_student.id
        @favorited = Favorite.where(favorited_student_id: current_student.id)
        @commented = PostComment.where(commented_student_id: current_student.id)
        @notifications = @commented.push(@favorited)
        @notifications.flatten!
      end
    elsif logged_in_as_coach?
      @favorited = Favorite.where(favorited_coach_id: current_coach.id)
      @commented = PostComment.where(commented_coach_id: current_coach.id)
      @notifications = @commented.push(@favorited)
      @notifications.flatten!
    end
  end
  
  def create
    
    if logged_in_as_student?
      @comment = current_student.post_comments.build(comment_params)
    else
      @comment = current_coach.post_comments.build(comment_params)
      @comment.coach_id = current_coach.id
    end
    @comment.commented_student_id = @comment.post.student.id
    
    if params[:comment]
      @comment.status = "comment"
    elsif params[:answer]
      @comment.status = "answer"
    end
    
    if params[:commented_post_comment_id]
      @comment.commented_post_comment_id = params[:commented_post_comment_id]
    end
    
    if params[:root_post_comment_id]
      @comment.root_post_comment_id = params[:root_post_comment_id]
    end
    
    if @comment.save
      if params[:comment]
        flash[:success] = "Comment created!"
      elsif params[:answer]
        flash[:success] = "Answer created!"
      end
      redirect_to :back
    else
      flash[:danger] = "コメントが作成できませんでした。captionを入力してください。"
      redirect_to :back
    end
    
  end
  
  def edit
    @comment = PostComment.find(params[:id])
    unless @comment.comment_pictures.present?
      @comment_pictures = @comment.comment_pictures.build
    end
  end
  
  def update
    @comment = PostComment.find(params[:id])
    if params[:comment]
      @comment.status = "comment"
    elsif params[:answer]
      @comment.status = "answer"
    end
    if @comment.update_attributes(update_comment_params)
      flash[:success] = "更新しました。"
      redirect_to :action => "new", :post_id => @comment.post_id
    else
      render 'edit'
    end
  end
  
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to :action => "new", :post_id => @comment.post_id
  end
  
  private
  
  def comment_params
    params.require(:post_comment).permit(:caption, :post_id, :commit, :commented_post_comment_id, :root_post_comment_id, { comment_pictures_attributes: [:pictures] })
  end
  
  def update_comment_params
    params.require(:post_comment).permit(:caption, :status, { comment_pictures_attributes: [:id, :pictures] })
  end
    
  def profile_check
    if logged_in_as_student?
      if (current_student.name == "no_name") || current_student.avatar.url.nil?
        flash[:info] = "プロフィール情報（nameとavatar）を更新してクエスチョン機能やアンサー機能を使ってみましょう！"
        redirect_to current_student
      end
    elsif logged_in_as_coach?
      if current_coach.name.nil? || current_coach.university.nil? || current_coach.major.nil? || current_coach.school_year.nil? || current_coach.self_introduction.nil?
        flash[:info] = "プロフィール情報を完成させてクエスチョンに答えてみよう！"
        redirect_to current_coach
      end
    end
  end
  
  def correct_user2
    post_comment = PostComment.find(params[:id])
    if logged_in_as_student?
      unless post_comment.student_id == current_student.id
        flash[:danger] = "Please log in as correct user."
        redirect_to(login_url)
      end
    elsif logged_in_as_coach?
      unless post_comment.coach_id == current_coach.id
        flash[:danger] = "Please log in as correct user."
        redirect_to(login_url)
      end
    else
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end

end