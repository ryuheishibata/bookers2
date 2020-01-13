class BooksController < ApplicationController
  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
  end

  def show
  	@books = Book.find(params[:id])
    @book = Book.new
  end

  def top
  	@book = Book.new
  	@books = Book.all
  end

  def create
  	book = Book.new(book_params)
    book.user_id = current_user.id
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
    if current_user != @book.user
      redirect_to books_path
    end
  end

  def update
  	book = Book.find(params[:id])
  	book.update(book_params)
  	if book.save
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(book.id)
    else
    @book = book
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
   def book_params
   	params.require(:book).permit(:title, :body)
   end

end
