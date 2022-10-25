class FavoritesController < ApplicationController

 def create
  book = Book.find(params[:book_id])
  favorite = current_user.Favorites.new(book_id: book.id)
  favorite.save
  redirect_to book_path(params[:book_id])
 end

 def destroy
  book = Book.find(params[:book_id])
  favorite = current_user.Favorites.new(book_id: book.id)
  favorite.destroy
  redirect_to book_path(params[:book_id])
 end

end
