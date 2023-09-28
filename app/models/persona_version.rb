class PersonaVersion < ApplicationRecord
    # Relationships
    belongs_to :persona
    
    # Validations
    validates :number, format: { with: /\A\d+\.\d\z/, message: "should be in the format X.X" }, uniqueness: { scope: :persona_id }, presence: true
    
    # Scopes
    scope :most_recent, -> { order(created_at: :desc).first }
    scope :ordered_by_version_desc, -> { order(number: :desc) }
    
  end
  