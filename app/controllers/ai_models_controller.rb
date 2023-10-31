class AiModelsController < ApplicationController
    def index
      @ai_models = AiModel.all
      authorize @ai_models
    end
    
    def show
      @ai_model = AiModel.find(params[:id])
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
      @ai_model = AiModel.find(params[:id])
      authorize @ai_model
    end
    
    def update
      @ai_model = AiModel.find(params[:id])
      authorize @ai_model
      if @ai_model.update(ai_model_params)
        redirect_to ai_model_path(@ai_model), notice: 'AI Model updated successfully.'
      else
        render :edit
      end
    end
    
    def destroy
      @ai_model = AiModel.find(params[:id])
      @ai_model.destroy
      redirect_to ai_models_path, notice: 'AI Model deleted.'
      authorize @ai_model
    end
    
    private
    
    def ai_model_params
      params.require(:ai_model).permit(:name, :description)
    end
  end
  
