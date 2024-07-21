class BrevoService
 
    def self.add_contact(email)
      new.add_contact(email)
    end
  
    def add_contact(email)
      api_instance = Brevo::ContactsApi.new
  
      create_contact = Brevo::CreateContact.new 
      create_contact = {
        'email'=> email,
        'listIds'=> [5] # This is the idea of the list at Brevo
      }
  
      begin
        result = api_instance.create_contact(create_contact)
        Rails.logger.info "Contact added: #{result}"
      rescue Brevo::ApiError => e
        Rails.logger.error "Exception when calling ContactsApi->create_contact: #{e.response_body}"
      end
    end

end