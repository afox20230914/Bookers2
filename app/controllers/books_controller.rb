class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)  
    else
      @books = Book.all             
      @book_new = @book            
      render :index                
    end
  end

def index
  @books = Book.includes(:user).order(created_at: :desc)
  @book_new = Book.new
end

def show
  @book = Book.find(params[:id])
  @user = @book.user
  @book_new = Book.new 
end

def edit
  @book = Book.find(params[:id])
  unless @book.user == current_user
    redirect_to books_path, alert: "不正なアクセスです"
  end
end

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path(@book), notice: "You have updated book successfully."
  else
    render :edit
  end
end

def destroy
  @book = Book.find(params[:id])
  if @book.user == current_user
    @book.destroy
    redirect_to books_path, notice: "You have destroy book successfully."
  else
    redirect_to book_path(@book), alert: "不正なアクセスです"
  end
end

private

def book_params
  params.require(:book).permit(:title, :body, :image, :opinion)
end
end