class CoachesController < ApplicationController
  before_action :logged_in_coach, only: [:edit, :update, :destroy]
  before_action :correct_coach, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:favorites]
  before_action :coach_profile_check, only: [:show, :favorites]
  
  def index
    @coaches = Coach.where(activated: true).full_profile.order("id").page(params[:page]).per_page(10)
  end
  
  def show
    coach = Coach.where(activated: true)
    @coach = coach.find(params[:id])
    @jr_subjects = @coach.subjects.slice(:jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social)
    @high_subjects = @coach.subjects.slice(:high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                           :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                           :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                           :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                           :basic_biology, :biology, :basic_earth_science, :earth_science)
    @certifications = @coach.certifications.slice(:eiken, :toeic, :toefl, :ielts, :kanken, :suuken)
    @post_comments = @coach.post_comments.order(created_at: :desc).page(params[:page]).per_page(5)
    if logged_in_as_coach?
      @reports_count = @coach.coaching_reports.readable_for(current_coach).count
      @comments_count = @coach.comments.count
      @favorites_count = @coach.favorites.count
    end
    @template = "show"
  end
  
  def new
    unless logged_in_as_coach?
      @coach = Coach.new(birthday: Date.new(1997, 1, 1))
    else
      flash[:danger] = "Please log out before creating a new coach account."
      redirect_to root_path
    end
  end
  
  def edit
    @coach = Coach.find(params[:id])
  end
  
  def create
    @coach = Coach.new(create_coach_params)
    @coach.subjects = CoachingSubject.new(subjects_params)
    @coach.certifications = CoachCertification.new(certifications_params)
    if @coach.save
      @coach.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def update
    @coach.assign_attributes(coach_params)
    if  @coach.save(context: :normal_update)
      flash[:success] = "Profile Edit Success!"
      redirect_to @coach
    else
      render "edit"
    end
  end
  
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy
    flash[:success] = "Deleted Your Account."
    redirect_to :coaches
  end
  
  def account
    @coach = Coach.find(params[:id])
  end
  
  def favorites
    @coach = Coach.find(params[:id])
    @favorites = @coach.favorites.order("created_at DESC")
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page]).per(10)
    #@reports = @coach.favorited_reports.order("favorites.created_at DESC")
    #@reports = Kaminari.paginate_array(@reports).page(params[:page]).per(5)
    @template = "favorites"
  end
  
  private
  
  def create_coach_params
    params.require(:coach).permit(:account_name, :email, :password, :password_confirmation)
  end
  
  def coach_params
    attrs = [:name, :account_name, :email, :birthday,
              :university, :major, :school_year,:self_introduction,
              :password, :password_confirmation, :avatar, :avatar_cache,
              :skype, :phone ]
    attrs << { subjects_attributes: [:id, :jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social,
                                     :high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                     :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                     :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                     :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                     :basic_biology, :biology, :basic_earth_science, :earth_science ] }
    attrs << { certifications_attributes: [:id, :eiken, :toeic, :toefl, :ielts, :kanken, :suuken ] }
    params.require(:coach).permit(attrs)
  end
  
  def subjects_params
    params.require(:coach).permit(:jr_english, :jr_japanese, :jr_math, :jr_science, :jr_social,
                                     :high_english, :modern_japanese, :classical_japanese, :classical_chinese,
                                     :world_history_a, :world_history_b, :japanese_history_a, :japanese_history_b,
                                     :geography_a, :geography_b, :contemporary_society, :ethics, :politics_economics,
                                     :math_1a, :math_2b, :math_3, :basic_physics, :physics, :basic_chemistry, :chemistry,
                                     :basic_biology, :biology, :basic_earth_science, :earth_science)
  end
  
  def certifications_params
    params.require(:coach).permit(:eiken, :toeic, :toefl, :ielts, :kanken, :suuken)
  end
  
  
  # 正しいユーザーかどうか確認
  def correct_coach
    @coach = Coach.find(params[:id])
    unless current_coach?(@coach) || current_coach.administrator?
      flash[:danger] = "Please log in correct coach."
      redirect_to(root_url)
    end
  end
  
  # ログイン済みユーザーかどうか確認
  def logged_in_coach
    unless logged_in_as_coach?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  def coach_profile_check
    coach = Coach.find(params[:id])
    unless coach == current_coach
      if (coach.avatar.url == nil ) || (coach.name == nil) || (coach.university == nil) || (coach.major == nil) || (coach.school_year == nil) || (coach.self_introduction == nil)
        flash[:info] = "お探しのアカウントは非表示になっています。"
        redirect_to root_url
      end
    end
  end
  
end
