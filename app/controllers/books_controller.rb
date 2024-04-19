
  class BooksController < ApplicationController
    before_action :authenticate_user!, only: %i[index edit update destroy]
 #   before_action :set_book_collection
    before_action :set_book, only: %i[show edit update destroy]
  
    def index
      @page_title = "Books"
      @books = @book_collection.books
      authorize @books
    end
  
    def show
      @page_title = "#{@book.title.titleize} by #{@book.author.name.titleize}"
      # genre = @book.book_genre
      # @related_books = genre.books.where.not(id: @book.id).limit(3)
      @related_books = Book.all
      authorize @book
      # Assuming you have a method to handle view tracking
      track_book_view(@book)
    end
  
    def new
      @book = Book.new
      authorize @book
    end
  
    def create
      @book = @book_collection.books.new(book_params)
      authorize @book
      if @book.save
        redirect_to [@book_collection, @book], notice: 'Book was successfully created.'
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
        redirect_to [@book_collection, @book], notice: 'Book was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @book
      @book.destroy
      redirect_to book_collection_books_path(@book_collection), notice: 'Book was successfully destroyed.'
    end
  
    private
  
    def set_book_collection
      @book_collection = BookCollection.friendly.find(params[:book_collection_id])
    end
  
    def set_book
      @book = Book.friendly.find(params[:id])
    end
  
    def book_params
      params.require(:book).permit(
        :title, :description, :cover, :publication_date,
        :title_tag_line, :series_number, :amazon_asin,
        :book_genre_id, :book_trope_id
      )
    end
  
    def track_book_view(book)
      AhoyEventTracker.new(@book, current_visit.visit_token).track_event
    end
  end
  