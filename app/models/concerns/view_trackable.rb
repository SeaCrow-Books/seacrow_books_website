module ViewTrackable
  extend ActiveSupport::Concern

  included do
    scope :most_viewed, ->(limit = 3) {
      select("#{table_name}.*, COUNT(ahoy_events.id) as view_count")
      .joins("INNER JOIN ahoy_events ON ahoy_events.name = CONCAT('#{name}:', #{table_name}.id)")
      .group("#{table_name}.id")
      .order('view_count DESC')
      .limit(limit)
    }

    scope :views_count, ->(record_id) {
      Ahoy::Event.where(name: "#{name}:#{record_id}").count
    }
  end

  def view_count
    Ahoy::Event.where(name: "#{self.class.name}:#{id}").count
  end

  def track_visit(ahoy, current_visit)
    return unless ahoy && current_visit

    event_name = generate_event_name
    ahoy.track event_name, current_visit.visit_token unless event_exists?(event_name, current_visit)
  end

  private

  def generate_event_name
    "#{self.class.name}:#{id}"
  end

  def event_exists?(event_name, current_visit)
    Ahoy::Event.where(name: event_name, properties: current_visit.visit_token).exists?
  end
end
