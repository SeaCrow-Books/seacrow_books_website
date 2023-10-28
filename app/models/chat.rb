class Chat < ApplicationRecord
    serialize :messages, Array
  
    before_save :initialize_messages
  
    def initialize_messages
      self.messages ||= []
    end
  end
  