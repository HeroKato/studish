class InquiryController < ApplicationController
  
  def index
    # 入力画面を表示
    @inquiry = Inquiry.new
    @coach = Coach.find(params[:id])
    render :action => 'index'
  end

  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    if params[:back]
      @inquiry = Inquiry.new(inquiry_params)
      if inquiry_params[:skype]
        render :action => 'index'
      else
        render :action => 'index'
      end
    else
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
    render :action => 'thanks'
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :category, :grade, :skype, :message)
  end

end