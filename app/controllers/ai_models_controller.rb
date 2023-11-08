class AiModelsController < ApplicationController
  before_action :set_ai_model, only: [:show, :edit, :update, :destroy]

  def index
    @ai_models = AiModel.all
    authorize @ai_models
  end
  
  def show
    authorize @ai_model
  end
  
  def new
    @ai_model = AiModel.new
    authorize @ai_model
  end
  
  def create
    @ai_model = AiModel.new(ai_model_params)
    authorize @ai_model
    if @ai_model.save
      redirect_to ai_models_path, notice: 'AI Model created successfully.'
    else
      render :new
    end
  end
  
  def edit
    authorize @ai_model
  end
  
  def update
    authorize @ai_model
    if @ai_model.update(ai_model_params)
      redirect_to ai_model_path(@ai_model), notice: 'AI Model updated successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    @ai_model.destroy
    redirect_to ai_models_path, notice: 'AI Model deleted.'
    authorize @ai_model
  end
  
  private
  
  def set_ai_model
    @ai_model = AiModel.friendly.find(params[:id])
  end
  
  def ai_model_params
    params.require(:ai_model).permit(:name, :description)
  end
end

