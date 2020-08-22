class Admin < ApplicationRecord
    # encrypt password
    has_secure_password

    # Validations
    validates_presence_of :first_name, :last_name, :email, :password_digest
    validates_uniqueness_of :email
end
