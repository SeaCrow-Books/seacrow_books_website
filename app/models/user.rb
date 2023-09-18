class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { staff: 0, admin: 1 }

  after_initialize :set_default_role, if: :new_record?

  # Sets full_name method e.g. @user.full_name
  def full_name
    [
      first_name&.capitalize,
      last_name&.capitalize
    ].compact.join(' ')
  end
     
  private
     
  # Set default role
  def set_default_role
    self.role ||= :staff
  end

end
