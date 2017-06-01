class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :notifications]
  before_action :correct_user, only: [:edit, :update, :destroy, :notifications]
  before_action :set_default_meta
  after_action :save_flags, only: [:notifications]
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @posts = @user.posts.page(params[:page]).per_page(5)
    @user_name = @user.name
    @user_account_name = @user.account_name
    @favorites_count = @user.favorites.count
    @answers_count = @user.post_comments.where(status: "answer").count
    if @user.user_type == "student"
      @questions_count = @user.posts.where(status: "question").count
      @notes_count = @user.posts.where(status: "note").count
    elsif @user.user_type == "coach"
      @logs_count = "0"
      @university = @user.expanded_coach_profile.university
      @major = @user.expanded_coach_profile.major
      @school_year = @user.expanded_coach_profile.school_year
      @reports_count = @user.posts.where(status: "report").count
      @jr_subjects = @user.subjects.slice(:jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social)
      @high_subjects = @user.subjects.slice(:high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                           :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                           :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                           :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                           :basic_biology, :biology, :basic_earth_science, :earth_science)
      @certifications = @user.certifications.slice(:eiken, :toeic, :toefl, :ielts, :kanken, :suuken)
    end
    set_meta_show
  end
  
  def new
    if params[:user_type]
      unless logged_in?
        @user = User.new
        @user.user_type = params[:user_type]
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
    if @user.user_type == "coach"
      @user.certifications = CoachCertification.new(certifications_params)
      @user.subjects = CoachingSubject.new(subjects_params)
      @user.expanded_coach_profile = ExpandedCoachProfile.new(expanded_coach_profile_params)
    end
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
    set_meta_edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated!"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page]).per(5)
    set_meta_favorites
  end
  
  def answers
    @user = User.find(params[:id])
    @answers = @user.post_comments.where(status: 'answer')
    @answers = Kaminari.paginate_array(@answers).page(params[:page]).per(5)
    set_meta_answers
  end
  
  def notifications
    @favorited = Favorite.where(favorited_user_id: current_user.id)
    @commented = PostComment.where(commented_user_id: current_user.id)
    @notifications = @commented.push(@favorited)
    @notifications.flatten!
    @notifications = @notifications.sort_by{ |n| n.created_at }
    @notifications = @notifications.reverse
    @notifications = Kaminari.paginate_array(@notifications).page(params[:page]).per(5)
  end
  
  private
  
  def create_user_params
    params.require(:user).permit(:user_type, :account_name, :email, :password, :password_confirmation)
  end
  
  def user_params
    attrs = [:name, :account_name, :email, :self_introduction,
              :password, :password_confirmation, :avatar, :avatar_cache,]
    attrs << { subjects_attributes: [:id, :jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social,
                                     :high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                     :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                     :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                     :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                     :basic_biology, :biology, :basic_earth_science, :earth_science ] }
    attrs << { certifications_attributes: [:id, :eiken, :toeic, :toefl, :ielts, :kanken, :suuken ] }
    attrs << { expanded_coach_profile_attributes: [:university, :major, :school_year, :skype ] }
    params.require(:user).permit(attrs)
  end
  
  def subjects_params
    params.require(:user).permit(:user_id, :jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social,
                                     :high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                     :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                     :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                     :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                     :basic_biology, :biology, :basic_earth_science, :earth_science)
  end
  
  def certifications_params
    params.require(:user).permit(:user_id, :eiken, :toeic, :toefl, :ielts, :kanken, :suuken)
  end
  
  def expanded_coach_profile_params
    params.require(:user).permit(:user_id, :university, :major, :school_year, :skype)
  end
  
  def activated?
    @user.activated == "true"
  end
  
  def set_meta_new
    @title = "新規登録 | Studish"
    @description = "ユーザー新規登録ページです。"
  end
  
  def set_meta_show
    @title = "#{@user.account_name} | Studish"
    @description = "#{@user.account_name}さんのプロフィールページです。"
    @creator = @user.account_name
    @twitter_title = "#{@user.account_name}さんのプロフィール"
    @twitter_description = "#{@user.account_name}さんのプロフィールページです。"
  end
  
  def set_meta_edit
    @title = "#{@user.account_name} - Profile Edit| Studish"
    @description = "#{@user.account_name}さんのプロフィール編集ページです。"
  end
  
  def set_meta_favorites
    @title = "#{@user.account_name} - Favorites | Studish"
    @description = "#{@user.account_name}さんのFavoritesページです。"
    @creator = @user.account_name
    @twitter_title = "#{@user.account_name}さんのFavorites"
    favorites_count = @user.favorites.count
    @twitter_description = "#{@user.account_name}さんはこれまでに#{favorites_count}回、いいねをしました。"
  end
  
  def set_meta_answers
    @title = "#{@user.account_name} - Answers | Studish"
    @description = "#{@user.account_name}さんのAnswersページです。"
    @creator = @user.account_name
    @twitter_title = "#{@user.account_name}さんのAnswers"
    answers_count = @user.posts.where(status: "answer")
    @twitter_description = "#{@user.account_name}さんはこれまでに#{answers_count}回、質問に答えました。"
  end
  
end