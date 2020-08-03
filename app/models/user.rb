class User < ApplicationRecord
    # encrypt password
    has_secure_password

    # Model associations
    has_many :items, dependent: :destroy, foreign_key: :owner
    # Validations
    validates_presence_of :first_name, :last_name, :email, :phone_number, :password_digest
end
