
  class BookCollectionsController < ApplicationController
    before_action :authenticate_user!, only: %i[edit update destroy]
    before_action :set_book_collection, only: %i[show edit update destroy]
    after_action :verify_policy_scoped, only: :index
    layout :set_layout


    # GET /publishing/authors/:author_id/series
    def index
      @book_collections = policy_scope(BookCollection)
    end

    # GET /publishing/authors/:author_id/series/:id
    def show
      @books = @book_collection.books.order(:series_number)
      authorize @book_collection
    end

    # GET /publishing/authors/:author_id/series/new
    def new
      @book_collection = BookCollection.new
      authorize @book_collection
    end

    # POST /publishing/authors/:author_id/series
    def create
      @book_collection = BookCollection.new(book_collection_params)
      authorize @book_collection

      if @book_collection.save
        redirect_to book_dashboard_path, notice: 'Series was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /publishing/authors/:author_id/series/:id/edit
    def edit
      authorize @book_collection
    end

    # PATCH/PUT /publishing/authors/:author_id/series/:id
    def update
      authorize @book_collection
      if @book_collection.update(book_collection_params)
        redirect_to book_dashboard_path, notice: 'Series was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /publishing/authors/:author_id/series/:id
    def destroy
      authorize @book_collection
      @book_collection.destroy
      redirect_to book_dashboard_path,
                  notice: 'Series was successfully destroyed.'
    end

    private

    def set_book_collection
      @book_collection = BookCollection.friendly.find(params[:id])
    end

    def set_author
      @author = Author.friendly.find(params[:author_id])
    end

    def book_collection_params
      params.require(:book_collection).permit(:name, :author_id)
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
