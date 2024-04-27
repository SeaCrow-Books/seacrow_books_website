class EmailCapturesController < ApplicationController
  before_action :set_email_capture, only: %i[ show edit update destroy ]

  # GET /email_captures or /email_captures.json
  def index
    @email_captures = EmailCapture.all
  end

  # GET /email_captures/1 or /email_captures/1.json
  def show
  end

  # GET /email_captures/new
  def new
    @email_capture = EmailCapture.new
  end

  # GET /email_captures/1/edit
  def edit
  end

  # POST /email_captures or /email_captures.json
  def create
    @email_capture = EmailCapture.new(email_capture_params)

    respond_to do |format|
      if @email_capture.save
        format.html { redirect_to free_books_download_path, notice: "Email capture was successfully created." }
        format.json { render :show, status: :created, location: @email_capture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email_capture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_captures/1 or /email_captures/1.json
  def update
    respond_to do |format|
      if @email_capture.update(email_capture_params)
        format.html { redirect_to email_capture_url(@email_capture), notice: "Email capture was successfully updated." }
        format.json { render :show, status: :ok, location: @email_capture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email_capture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_captures/1 or /email_captures/1.json
  def destroy
    @email_capture.destroy!

    respond_to do |format|
      format.html { redirect_to email_captures_url, notice: "Email capture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_capture
      @email_capture = EmailCapture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_capture_params
      params.require(:email_capture).permit(:email)
    end
end
