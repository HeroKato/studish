class PostCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :profile_check, only: [:new, :create]
  after_action :save_flags, only: [:new]
  before_action :set_default_meta
  
  def index
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
  end
  
  def new
    @comment = PostComment.new(post_id: params[:post_id], user_id: params[:user_id], commented_user_id: params[:commented_user_id], commented_post_comment_id: params[:commented_post_comment_id])
    @comment.comment_pictures.new
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
    if params[:commented_post_comment_id]
      @commented_post_comment = PostComment.find_by(id: params[:commented_post_comment_id])
      @comments = PostComment.where(commented_post_comment_id: params[:commented_post_comment_id]).order(created_at: :desc).page(params[:page]).per_page(5)
    end
    set_notifications
    set_meta_new
  end
  
  def create
    @comment = current_user.post_comments.build(comment_params)
    @comment.status = params[:status]
    @post = Post.find_by(id: params[:post_comment][:post_id])
    if @comment.save
      if params[:status] == "comment"
        flash[:success] = "Comment created!"
      elsif params[:status] == "answer"
        flash[:success] = "Answer created!"
      end
      if @comment.commented_post_comment_id.present?
        @commented_post_comment = PostComment.find_by(id: params[:post_comment][:commented_post_comment_id])
        @comments = PostComment.where(commented_post_comment_id: params[:post_comment][:commented_post_comment_id]).order(created_at: :desc).page(params[:page]).per_page(5)
        redirect_to new_post_comment_path(post_id: params[:post_comment][:post_id], commented_post_comment_id: params[:post_comment][:commented_post_comment_id])
      else
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
        redirect_to new_post_comment_path(post_id: params[:post_comment][:post_id])
      end
    else
      if params[:post_comment][:commented_post_comment_id].present?
        @commented_post_comment = PostComment.find_by(id: params[:post_comment][:commented_post_comment_id])
        @comments = PostComment.where(commented_post_comment_id: params[:post_comment][:commented_post_comment_id]).order(created_at: :desc).page(params[:page]).per_page(5)
      else
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
      end
      render 'new'
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
    redirect_to request.referrer || root_url
  end
  
  private
  
  def comment_params
    params.require(:post_comment).permit(:user_id, :post_id, :caption, :status, :commented_post_comment_id, :commented_user_id, { comment_pictures_attributes: [:pictures] })
  end
  
  def update_comment_params
    params.require(:post_comment).permit(:caption, :status, { comment_pictures_attributes: [:id, :pictures] })
  end
    
  def profile_check
    if logged_in?
      if (current_user.name == "no_name") || current_user.avatar.url.nil?
        flash[:info] = "プロフィール情報（nameとavatar）を更新してクエスチョン機能やアンサー機能を使ってみましょう！"
        redirect_to current_user
      end
    end
  end
  
  def correct_user
    @post_comment = current_user.post_comments.find_by(id: params[:id])
    redirect_to root_url if @post_comment.nil?
  end
  
  def set_meta_new
    if @commented_post_comment.present?
      @title = "NewPostComment - #{@commented_post_comment.user.account_name} | Studish"
      @description = "PostComment-id-#{@commented_post_comment.id}へのコメント投稿ページです。"
      @creator = @commented_post_comment.user.account_name
      @twitter_title = "#{@creator}さんのコメント"
      @twitter_description = "#{@commented_post_comment.caption}"
    elsif @post.present?
      @title = "NewPostComment - #{@post.user.account_name} | Studish"
      @description = "Post-id-#{@post.id}へのコメント投稿ページです。"
      @creator = @post.user.account_name
      if @post.status == "question"
        @twitter_title = "#{@creator}さんが#{@post.subject}について質問しています。"
      elsif @post.status == "note"
        notes_count = @post.user.posts.where(status: "note").count
        @twitter_title = "#{@post.user.account_name}さんが#{notes_count}個目のnoteを投稿しました。"
      end
      @twitter_description = "#{@post.caption}"
    end
    
    if @comments.present?
      if @comments.first.comment_pictures.present?
        @twitter_image_url = @comments.first.comment_pictures.first.pictures.large.url
      end
    end
  end
  
  def set_notifications
    if logged_in?
      @favorited = Favorite.where(favorited_user_id: current_user.id)
      @commented = PostComment.where(commented_user_id: current_user.id)
      @notifications = @commented.push(@favorited)
      @notifications.flatten!
    end
  end

end