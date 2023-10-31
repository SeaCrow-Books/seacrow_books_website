class ChatSessionsController < ApplicationController
  before_action :authenticate_user!
    before_action :set_chat_session, only: [:show, :destroy]
  
    def index
      @chat_sessions = ChatSession.all
      authorize @chat_sessions
    end
  
    def new
      @chat_session = ChatSession.new
      @chat_custom_instructions = ChatCustomInstruction.all
      authorize @chat_session
    end
  
    def create
      @chat_session = current_user.chat_sessions.new(chat_session_params)
      authorize @chat_session
      if @chat_session.save
        redirect_to chat_session_path(@chat_session)  # This should redirect to the chat session's show page
      else
        render :new
      end
    end
      
      def update
        @chat_session = ChatSession.find(params[:id])
        authorize @chat_session
        if @chat_session.update(chat_session_params)
          redirect_to chat_sessions_path, notice: 'Chat name updated Daddy!'
        else
          redirect_to chat_sessions_path, alert: 'There was an error updating the chat session.'
        end
      end  
  
      def show
        @chat = Chat.new
        @chats = @chat_session.chats
        authorize @chat_session
      end
      
    def destroy
      @chat_session.destroy
      redirect_to chat_sessions_path
      authorize @chat_session
    end
  
    private
  
    def set_chat_session
      @chat_session = ChatSession.find(params[:id])
    end
  
    def chat_session_params
      params.require(:chat_session).permit(:session_name, :chat_custom_instruction_id, :ai_model_id)
    end
  end
  