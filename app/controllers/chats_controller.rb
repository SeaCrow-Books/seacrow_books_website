class ChatsController < ApplicationController
    before_action :set_chat_session
  
    def create
      user_input = params[:chat][:content]
      @chat = @chat_session.chats.create(role: 'user', content: user_input)
      
      mode = @chat_session.mode # Retrieve the mode from the chat session
      bot_response = OpenaiService.chat(user_input, mode) # Pass the mode to OpenaiService
      
      @chat_session.chats.create(role: 'assistant', content: bot_response)
      redirect_to chat_session_path(@chat_session)
    end
  
    private
  
    def set_chat_session
      @chat_session = ChatSession.find(params[:chat_session_id])
    end
  end
  