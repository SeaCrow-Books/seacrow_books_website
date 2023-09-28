class PersonaVersionsController < ApplicationController
  before_action :set_persona_version, only: %i[show edit update destroy]
  before_action :set_persona, only: %i[new create edit update]

  def index
    @persona_versions = PersonaVersion.all
    authorize @persona_versions
    @page_title = 'Persona Versions' 
    @page_description = 'Manage versions of each persona.'
  end

  def show
    authorize @persona_version
    @page_title = @persona_version.number.to_s
    @page_description = 'Details of the persona version.'
  end

  def new
    @persona_version = @persona.persona_versions.build
    @page_title = "New Persona Version for " + @persona.name.titleize
    authorize @persona_version
  end

  def create
    @persona_version = @persona.persona_versions.build(persona_version_params)
    authorize @persona_version
    if @persona_version.save
      redirect_to @persona, notice: 'Persona version was successfully updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @persona_version
    @page_title = "Editing Version " + @persona_version.number.to_s + " for " + @persona.name.titleize
  end

  def update
    authorize @persona_version
    if @persona_version.update(persona_version_params)
      redirect_to @persona, notice: 'Persona version was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @persona_version
    @persona_version.destroy
    redirect_to persona_persona_versions_url(@persona), notice: 'Persona version was successfully destroyed.'
  end

  private

  def set_persona_version
    @persona_version = PersonaVersion.find(params[:id])
  end

  def set_persona
    @persona = Persona.friendly.find(params[:persona_id])
  end

  def persona_version_params
    params.require(:persona_version).permit(:number, :prompt, :document_link)
  end
end
