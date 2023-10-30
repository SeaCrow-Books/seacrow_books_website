class OpenaiService
  BASE_URL = 'https://api.openai.com/v1/chat/completions'.freeze

  def self.chat(user_input, custom_instruction, chat_session_id)
    headers = {
      'Authorization' => "Bearer #{Rails.application.credentials.openai[:api_key]}",
      'Content-Type' => 'application/json'
    }
  
    chat_session = ChatSession.find(chat_session_id)
    custom_instruction = chat_session.chat_custom_instruction.instruction_text

    payload = {
      'model': 'gpt-4',
      'messages': [
        { 'role': 'system', 'content': custom_instruction },
        { 'role': 'user', 'content': user_input }
      ]
    }.to_json

    response = RestClient.post(BASE_URL, payload, headers)
    response_json = JSON.parse(response.body)
    response_json['choices'].first['message']['content']
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error "OpenAI API error: #{e.response}"
    raise
  end  

  # Extracts the model
  def self.model_name
    payload = {
      'model': 'gpt-4',
    }
    payload[:model]
  end

end
