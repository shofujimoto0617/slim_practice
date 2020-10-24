class BooksController < ApplicationController
  def new
  	@book = Book.new
  end

  def create
  	@book = current_user.books.new(book_params)
  	if @book.save
  	  redirect_to book_path(@book), notice: "You have created book successfully."
  	else
  	  render :new
  	end
  end

  def index
  	@books = Book.all
  end

  def show
  	@book = Book.find(params[:id])
  	@user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have update book successfully"
    else
      render :edit
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "Book「#{@book.title}」を削除しました。"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
