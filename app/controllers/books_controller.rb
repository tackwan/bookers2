class BooksController < ApplicationController
  def new
    @form = Book.new

  end

  def create
    @form = Book.new(book_params)
    @form.user_id = current_user.id
    if @form.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@form)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @form = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @form = Book.new
    @user = @book.user
  end

  def edit
    is_book
    @book = Book.find(params[:id])
  end

  def update
    is_book
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def is_book
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end
end
