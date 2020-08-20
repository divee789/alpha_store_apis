class User < ApplicationRecord
    # encrypt password
    has_secure_password

    # Model associations
    has_many :items, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :orders
    has_many :ratings
    # Validations
    validates_presence_of :first_name, :last_name, :email, :phone_number, :password_digest
    validates_uniqueness_of :email, :phone_number
end
