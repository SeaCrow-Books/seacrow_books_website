class EmailCapture < ApplicationRecord

    # Validations
    validates :email, presence: true

    # Callbacks
    after_create :add_to_brevo

    private

    def add_to_brevo
        BrevoService.add_contact(email)
    end

end
