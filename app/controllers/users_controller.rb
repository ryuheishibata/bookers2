class UsersController < ApplicationController
  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  	if @user.save
    flash[:notice] = " User was successfully updated."
    redirect_to user_path(@user.id)
    else
    render :edit
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
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end


end
