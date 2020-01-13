class HomesController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @books = Book.all
  end

  def create
    book = Book.new(book_params)
    if book.save
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(book.id)
    else
    @book = book
    @books = Book.all
    render :index
    end

  end
  def edit
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    if book.save
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(book.id)
    end

  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path(@books)
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end


end

