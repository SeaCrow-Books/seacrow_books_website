class BookSectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book
    before_action :set_book_section, only: %i[show edit update destroy]
    before_action :authorize_book_section, only: %i[show edit update destroy]
  
    # GET /books/:book_id/book_sections
    def index
      @book_sections = @book.book_sections.order(:position)
      authorize @book_sections
    end
  
    # GET /books/:book_id/book_sections/:id
    def show
    end
  
    # GET /books/:book_id/book_sections/new
    def new
      @book_section = @book.book_sections.build
      authorize @book_section
    end
  
    # GET /books/:book_id/book_sections/:id/edit
    def edit
    end
  
    # POST /books/:book_id/book_sections
    def create
      @book_section = @book.book_sections.build(book_section_params)
      authorize @book_section
  
      if @book_section.save
        redirect_to [@book, @book_section], notice: "Book section was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /books/:book_id/book_sections/:id
    def update
      if @book_section.update(book_section_params)
        redirect_to [@book, @book_section], notice: "Book section was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /books/:book_id/book_sections/:id
    def destroy
      @book_section.destroy
      redirect_to book_book_sections_url(@book), notice: "Book section was successfully destroyed."
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_book
        @book = Book.friendly.find(params[:book_id])
    end
  
    def set_book_section
      @book_section = @book.book_sections.friendly.find(params[:id])
    end
  
    def authorize_book_section
      authorize @book_section
    end
  
    # Only allow a list of trusted parameters through.
    def book_section_params
      params.require(:book_section).permit(:title, :content, :position, :epub_type)
    end
  end
  