class PersonasController < ApplicationController
  before_action :authenticate_user!
    before_action :set_persona, only: %i[show edit update destroy]
  
    def index
      @personas = Persona.all
      @blog_personas = Persona.where(content_type: 'post')
      @book_personas = Persona.where(content_type: 'book')
      authorize @personas
      @page_title = 'Personas' 
      @page_description = 'Manage different personas for content.'
    end
  
    def show
      authorize @persona
      @most_recent_version = @persona.persona_versions.most_recent
      @page_title = @persona.name.titleize 
      @page_description = 'Details of the persona.'
    end
  
    def new
      @persona = Persona.new
      @persona_version = @persona.persona_versions.build
      @page_title = "New Persona"
      authorize @persona
    end
  
    def create
      @persona = Persona.new(persona_params)
      authorize @persona
      if @persona.save
        redirect_to @persona, notice: 'Persona was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @persona
      @persona.persona_versions.build unless @persona.persona_versions.any?
      @page_title = "Editing " + @persona.name.titleize 
    end
  
    def update
      authorize @persona
      if @persona.update(persona_params)
        redirect_to @persona, notice: 'Persona was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @persona
      @persona.destroy
      redirect_to personas_url, notice: 'Persona was successfully destroyed.'
    end
  
    private
  
    def set_persona
      @persona = Persona.friendly.find(params[:id])
    end
  
    def persona_params
      params.require(:persona).permit(:name, :content_type, :description, :ai_version, persona_versions_attributes: [:id, :number, :prompt, :document_link])
    end
  end
  