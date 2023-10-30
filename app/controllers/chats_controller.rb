class ChatsController < ApplicationController
    before_action :set_chat_session
  
    def create
      user_input = params[:chat][:content]
      @chat = @chat_session.chats.create(role: 'user', content: user_input)
          
      chat_session_id = @chat_session.id
      custom_instruction = @chat_session.chat_custom_instruction.instruction_text
      bot_response = OpenaiService.chat(user_input, custom_instruction, chat_session_id)  # Updated line
          
      @chat_session.chats.create(role: 'assistant', content: bot_response)
      redirect_to chat_session_path(@chat_session)
    end
    
      
    private
  
    def set_chat_session
      @chat_session = ChatSession.find(params[:chat_session_id])
    end
  end
  