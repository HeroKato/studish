class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :profile_check, only: [:new, :create]
  before_action :set_default_meta
  
  def index
    @posts = Post.where("status IN (?) OR status IN (?) " , "question", "note").page(params[:page]).per_page(5)
    set_meta_index
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
    @root_post_comments = @post_comments.where(root_post_comment_id: '')
    @branch_post_comments = @post_comments.where(root_post_comment_id.exists)
  end
  
  def new
    if params[:status] == "question"
      @post = Post.new(status: "question")
    else
      @post = Post.new(status: "note")
    end
    set_meta_new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.post_pictures.length < 3
      if @post.save
        if @post.status == "question"
         flash[:success] = "Questionを投稿しました！"
        elsif @post.status == "note"
         flash[:success] = "Noteを投稿しました！"
        end
        redirect_to :posts
      else
        unless @post.post_pictures.present?
          @post.post_pictures.new
        end
        render "new"
      end
    else
      flash[:danger] = "画像は最大2つまでです。"
      @post.post_pictures.new
      render "new"
    end
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
    set_meta_edit
  end
  
  def update
    @post = current_student.posts.find(params[:id])
    if @post.update_attributes(update_post_params)
      flash[:success] = "ポストを更新しました。"
      redirect_to :action => "index"
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "ポストを削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :status, :caption, :subject, :text_name, :chapter, :section,
                                 :page, :number, :pattern, {post_pictures_attributes: [:pictures]} )
  end
  
  def update_post_params
    params.require(:post).permit(:caption,:subject, :text_name, :chapter, :section,
                                 :page, :number, :pattern, {post_pictures_attributes: [:id, :pictures]} )
  end
  
  def profile_check
    if logged_in?
      if (current_user.name == "no_name") || current_user.avatar.url.nil?
        flash[:info] = "機能を使う前にユーザーネームとアバターを更新してください。"
        redirect_to current_user
      end
    end
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
  
  def set_meta_index
    @title = "Questions/Notes | Studish"
    @description = "QuestionsとNotesの一覧ページです。"
    @twitter_title = "たくさんのQuestionとNoteが投稿されています!"
    @twitter_description = "ユーザーからのQuestionsとNotesをチェックしてみましょう!"
  end
  
  def set_meta_edit
    @title = "編集 - #{@post.status}-id-#{@post.id} | Studish"
    @description = "#{@post.status}の編集ページです。"
  end
  
  def set_meta_new
    if @post.status == "question"
      post_type = "Question"
    else
      post_type = "Note"
    end
    @title = "#{post_type}の投稿 | Studish"
    @description = "#{post_type}の投稿ページです。"
  end
  
end