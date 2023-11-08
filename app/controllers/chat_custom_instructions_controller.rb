class ChatCustomInstructionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_custom_instruction, only: %i[show edit update destroy]
  before_action :authorize_chat_custom_instruction, only: %i[show edit update destroy]

  def index
    @chat_custom_instructions = ChatCustomInstruction.public_or_owned_by(current_user)
  end

  def show
  end

  def new
    @chat_custom_instruction = ChatCustomInstruction.new # <-- Note the singular model name
    authorize @chat_custom_instruction
  end

  def create
    @chat_custom_instruction = current_user.chat_custom_instructions.new(chat_custom_instruction_params)
    authorize @chat_custom_instruction

    if @chat_custom_instruction.save
      redirect_to @chat_custom_instruction, notice: 'Custom instruction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @chat_custom_instruction.update(chat_custom_instruction_params)
      redirect_to @chat_custom_instruction, notice: 'Custom instruction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat_custom_instruction.destroy
    redirect_to chat_custom_instructions_url, notice: 'Custom instruction was successfully destroyed.'
  end

  private

  def set_chat_custom_instruction
    @chat_custom_instruction = ChatCustomInstruction.friendly.find(params[:id])
    authorize @chat_custom_instruction
  end

  def authorize_chat_custom_instruction
    authorize @chat_custom_instruction
  end

  def chat_custom_instruction_params
    params.require(:chat_custom_instruction).permit(:name, :instruction_text, :status)
  end
end