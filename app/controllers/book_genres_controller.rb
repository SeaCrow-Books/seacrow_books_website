class BookGenresController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :set_book_genre, only: %i[show edit update destroy]
  layout :set_layout


  def index
    @page_title = "Book Genres"
    @book_genres = policy_scope(BookGenre)
    authorize @book_genres
  end

  def show
    @page_title = @book_genre.name.titleize
    @genre_books = @book_genre.books.order(:series_number)
    authorize @book_genre
  end

  def new
    @book_genre = BookGenre.new
    authorize @book_genre
  end

  def create
    @book_genre = BookGenre.new(book_genre_params)
    authorize @book_genre
    if @book_genre.save
      redirect_to book_dashboard_path, notice: 'Book genre was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @book_genre
  end

  def update
    authorize @book_genre
    if @book_genre.update(book_genre_params)
      redirect_to book_dashboard_path, notice: 'Book genre was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @book_genre
    @book_genre.destroy
    redirect_to book_dashboard_path, notice: 'Book genre was successfully destroyed.'
  end

  private

  def set_book_genre
    @book_genre = BookGenre.friendly.find(params[:id])
  end

  def book_genre_params
    params.require(:book_genre).permit(:name)
  end

  def set_layout
    case action_name
    when 
      'page_templates/tiny_page'
    when 'new', 'edit'
      'page_templates/small_page'
    when
      'page_templates/medium_page'
    when 'index', 'show'
      'page_templates/large_page'
    else
      'application'
    end
  end
  
end