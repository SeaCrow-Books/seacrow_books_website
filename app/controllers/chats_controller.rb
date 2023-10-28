class ChatsController < ApplicationController
    def index
        @page_title = "SeaCrow Chitty Chatty"
        @chat = Chat.last || Chat.create
        @model_name = OpenaiService.model_name
    end
      
    def create
        @chat = Chat.last || Chat.create
        user_input = params[:user_input]
        @chat.messages << {'role': 'user', 'content': user_input}
        bot_response = OpenaiService.chat(@chat)
        @chat.messages << {'role': 'assistant', 'content': bot_response}
        @chat.save
        redirect_to chats_path
    end
end
