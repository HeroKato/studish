class WelcomeController < ApplicationController
  
  def index
    @inquiry = Inquiry.new
    set_meta_index
  end
  
  private
  
  def set_meta_index
    @title = "Top | Studish"
    @twitter_title = "Studish = オンラインコーチ × Question機能 × Note機能"
    @twitter_description = "Studishはオンライン個別指導サービスです。科目指導＋コーチングで中高生の勉強を強力にサポートします。"
  end
  
end