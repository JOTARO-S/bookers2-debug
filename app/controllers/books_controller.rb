class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update, :destroy]
   before_action :book_detail, only: [:show]
   
  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @book = Book.all.order(params[:sort])
    @booka = Book.includes(:favorited_users).
      sort_by {|x| 
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
    }.reverse
    @books = Book.new
  end

  def create
    @books = Book.new(book_params)
    @books.user_id = current_user.id
    if @books.save
      redirect_to book_path(@books), notice: "You have created book successfully."
    else
      @book = Book.order(params[:sort])
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :tag, :star)
  end
  
  def is_matching_login_user
    user_id = Book.find(params[:id]).user_id
    if(user_id != current_user.id)
      redirect_to books_path
    end
  end
  
  def book_detail
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
  end
  
end
