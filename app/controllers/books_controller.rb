class BooksController < ApplicationController
    before_action :set_book, only: %i[show edit update destroy]
    
    def index
      @books = policy_scope(Book)
      authorize @books
    end
  
    def show
      @page_title = "#{@book.title.titleize} by #{@book.author_name.titleize}"
      authorize @book
    end
  
    def new
      @book = Book.new
      authorize @book
    end
  
    def create
      @book = Book.new(book_params)
      authorize @book
      if @book.save
        redirect_to @book, notice: 'Book was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @book
    end
  
    def update
      authorize @book
      if @book.update(book_params)
        redirect_to @book, notice: 'Book was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @book
      @book.destroy
      redirect_to dashboard_path, notice: 'Book was successfully destroyed.'
    end
  
    private
  
    def set_book
      @book = Book.friendly.find(params[:id])
    end
  
    def book_params
      params.require(:book).permit(:title, :description, :cover, :author_name, :publication_date, genre_ids: [])
    end
  end
  