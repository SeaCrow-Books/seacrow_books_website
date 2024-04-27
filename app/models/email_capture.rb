class EmailCapture < ApplicationRecord

    # Validations
    validates :email, presence: true

end
