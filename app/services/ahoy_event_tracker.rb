class AhoyEventTracker
    def initialize(resource, visit_token)
      @resource = resource
      @visit_token = visit_token
      @event_name = generate_event_name
    end
  
    def track_event
      return if event_exists?
      
      Ahoy::Event.create(name: @event_name, properties: { visit_token: @visit_token })
    end
    
  
    private
  
    def generate_event_name
        "#{@resource.class.name}:#{@resource.id}"  # Use @resource instead of resource
      end
      
  
    def event_exists?
      Ahoy::Event.where(name: @event_name, properties: @visit_token).exists?
    end
  end
  