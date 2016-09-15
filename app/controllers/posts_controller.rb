class PostsController < ApplicationController
  before_action :logged_in_student
  before_action :correct_student, only: [:destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
    @student = Student.find(params[:id])
    @posts = @student.posts
  end
  
  def new
    @post = Post.new
    @post.post_pictures.build
  end
  
  def create
    @post = current_student.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @post = current_student.posts.find(params[:id])
    @post.destroy
    flash[:success] = "ポストを削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:caption, { post_pictures_attributes: [:pictures] })
  end
end