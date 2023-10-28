class OpenaiService
  BASE_URL = 'https://api.openai.com/v1/chat/completions'.freeze

  def self.chat(chat)
    headers = {
      'Authorization' => "Bearer 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",
      'Content-Type' => 'application/json'
    }

    payload = {
      'model': 'gpt-4',
      'messages': chat.messages
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
