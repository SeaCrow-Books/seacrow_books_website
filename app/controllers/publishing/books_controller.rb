module Publishing
  class BooksController < BasePublishingController
    before_action :authenticate_user!, only: %i[index edit update destroy]
    before_action :set_book, only: %i[show edit update destroy]
    
    def index
      @page_title = "Books"
      @books = policy_scope(Book)
      authorize @books
    end
  
    def show
      @page_title = "#{@book.title.titleize} by #{@book.author.name.titleize}"
      genre = @book.genres.first
      # Exclude the current book and retrieve the top 3 most viewed books from the same genre
      @related_books = genre.books.where.not(id: @book.id)
      
      authorize @book

      # Tracking the view
      AhoyEventTracker.new(@book, current_visit.visit_token).track_event
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
      params.require(:publishing_book).permit(
        :title,
        :description,
        :cover,
        :book_collection_id,
        :author_id,
        :publication_date,
        :title_tag_line,   
        :series_number,   
        genre_ids: []
      )
    end
  end
end