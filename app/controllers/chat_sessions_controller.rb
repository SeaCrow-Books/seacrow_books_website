class ChatSessionsController < ApplicationController
    before_action :set_chat_session, only: [:show, :destroy]
  
    def index
      @chat_sessions = ChatSession.all
    end
  
    def new
      @chat_session = ChatSession.new
    end
  
    def create
        @chat_session = ChatSession.new(chat_session_params)
        if @chat_session.save
          redirect_to chat_session_path(@chat_session)  # This should redirect to the chat session's show page
        else
          render :new
        end
      end
      
  
      def show
        @chat = Chat.new
        @chats = @chat_session.chats
      end
      
    def destroy
      @chat_session.destroy
      redirect_to chat_sessions_path
    end
  
    private
  
    def set_chat_session
      @chat_session = ChatSession.find(params[:id])
    end
  
    def chat_session_params
      params.require(:chat_session).permit(:session_name)
    end
  end
  