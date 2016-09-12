class CoachesController < ApplicationController
  before_action :logged_in_coach, only: [:edit, :update, :destroy]
  before_action :correct_coach, only:[:edit, :update, :destroy]
  
  def index
    @coaches = Coach.where(activated: true).full_profile.order("id").paginate(page: params[:page])
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
    @coach = Coach.new(coach_params)
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
    @reports = @coach.favorited_reports.order("favorites.created_at DESC").paginate(page: params[:page])
    @template = "favorites"
  end
  
  private
  
  def coach_params
    attrs = [:name, :account_name, :email, :birthday,
              :university, :major, :school_year,:self_introduction,
              :password, :password_confirmation, :picture, :picture_cache,
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
  
end
