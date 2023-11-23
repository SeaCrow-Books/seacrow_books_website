module Publishing
  class BookCollectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book_collection, only: %i[show edit update destroy]
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    # GET /publishing/authors/:author_id/series
    def index
      @book_collections = policy_scope(Publishing::BookCollection)
    end

    # GET /publishing/authors/:author_id/series/:id
    def show
      authorize @book_collection
    end

    # GET /publishing/authors/:author_id/series/new
    def new
      @book_collection = BookCollection.new
      authorize @book_collection
    end

    # POST /publishing/authors/:author_id/series
    def create
      @book_collection = Publishing::BookCollection.new(book_collection_params)
      authorize @book_collection

      if @book_collection.save
        redirect_to publishing_book_collections_path, notice: 'Series was successfully created.'
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
        redirect_to publishing_book_collections_path, notice: 'Series was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /publishing/authors/:author_id/series/:id
    def destroy
      authorize @book_collection
      @book_collection.destroy
      redirect_to publishing_book_collections_path,
                  notice: 'Series was successfully destroyed.'
    end

    private

    def set_book_collection
      @book_collection = Publishing::BookCollection.friendly.find(params[:id])
    end

    def set_author
      @author = Publishing::Author.friendly.find(params[:author_id])
    end

    def book_collection_params
      params.require(:publishing_book_collection).permit(:name, :author_id)
    end
  end
end
