
  class BooksController < ApplicationController
    before_action :authenticate_user!, only: %i[index edit update destroy]
    before_action :set_book, only: %i[show edit update destroy]
    layout :set_layout

  
    def index
      @page_title = "Books"
      @books = @book_collection.books
      authorize @books
    end
  
    def show
      @page_title = "#{@book.title.titleize} by #{@book.author.name.titleize}"
      @related_books = Book.all
      @email_capture = EmailCapture.new
      authorize @book
      track_book_view(@book)
    end
  
    def new
      @book = Book.new
      authorize @book
    end
  
    def create
      @book = Book.new(book_params)
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

    def free_books_download
      @book = Book.find_by(title: 'The Stories')
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
        :title, 
        :description, 
        :cover, 
        :publication_date, 
        :title_tag_line, 
        :series_number, 
        :amazon_asin, 
        :book_genre_id, 
        :book_trope_id,
        :author_id,              
        :book_collection_id,
        :manuscript_pdf, 
        :manuscript_epub
      )
    end
    
    def set_layout
      case action_name
      when 
        'page_templates/tiny_page'
      when 
        'page_templates/small_page'
      when
        'page_templates/medium_page'
      when 'show', 'new', 'edit', 'free_books_download'
        'page_templates/large_page'
      else
        'application'
      end
    end
  
    def track_book_view(book)
      AhoyEventTracker.new(@book, current_visit.visit_token).track_event
    end
  end
  