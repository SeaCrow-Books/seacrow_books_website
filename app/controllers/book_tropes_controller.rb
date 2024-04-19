class BookTropesController < ApplicationController
  before_action :set_book_trope, only: %i[ show edit update destroy ]

  # GET /book_tropes or /book_tropes.json
  def index
    @book_tropes = BookTrope.all
  end

  # GET /book_tropes/1 or /book_tropes/1.json
  def show
  end

  # GET /book_tropes/new
  def new
    @book_trope = BookTrope.new
  end

  # GET /book_tropes/1/edit
  def edit
  end

  # POST /book_tropes or /book_tropes.json
  def create
    @book_trope = BookTrope.new(book_trope_params)

    respond_to do |format|
      if @book_trope.save
        format.html { redirect_to book_dashboard_path, notice: "Book trope was successfully created." }
        format.json { render :show, status: :created, location: @book_trope }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_trope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_tropes/1 or /book_tropes/1.json
  def update
    respond_to do |format|
      if @book_trope.update(book_trope_params)
        format.html { redirect_to book_dashboard_path, notice: "Book trope was successfully updated." }
        format.json { render :show, status: :ok, location: @book_trope }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_trope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_tropes/1 or /book_tropes/1.json
  def destroy
    @book_trope.destroy!

    respond_to do |format|
      format.html { redirect_to book_dashboard_path, notice: "Book trope was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_trope
      @book_trope = BookTrope.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_trope_params
      params.require(:book_trope).permit(:name, :slug)
    end
end
