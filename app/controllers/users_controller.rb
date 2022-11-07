class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]
  before_action :set_user, only: [:followings, :followers]

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @books = Book.new
    @today = @book.created_today
    @yesterday = @book.created_yesterday
    @thisweek = @book.created_thisweek
    @lastweek = @book.created_lastweek
  end

  def index
    @users = User.all
    @books = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def search
    @user = User.find(params[:user_id])
    @book = @user.books 
    @books = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @book.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end