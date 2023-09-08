module Viewable
    extend ActiveSupport::Concern
  
    included do
      # This scope returns the records with the highest number of views.
      scope :most_viewed, ->(limit = 3) {
        select("#{table_name}.*, COUNT(ahoy_events.id) as view_count")
        .joins("INNER JOIN ahoy_events ON ahoy_events.name = CONCAT('#{name}:', #{table_name}.id)")
        .group("#{table_name}.id")
        .order('view_count DESC')
        .limit(limit)
      }
    end
end