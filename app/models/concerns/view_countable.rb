module ViewCountable
    extend ActiveSupport::Concern
  
    def view_count
      Ahoy::Event.where(name: "#{self.class.name}:#{id}").count
    end
end
  