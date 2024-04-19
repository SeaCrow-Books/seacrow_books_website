class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :chat_custom_instructions, dependent: :destroy
  has_many :chat_sessions, dependent: :destroy

  enum role: { staff: 0, admin: 1, manager: 2 }

  after_initialize :set_default_role, if: :new_record?

  # Sets full_name method e.g. @user.full_name
  def full_name
    [
      first_name&.capitalize,
      last_name&.capitalize
    ].compact.join(' ')
  end

  def management?
    admin? || staff?
  end
     
  private
     
  # Set default role
  def set_default_role
    self.role ||= :staff
  end



end
