class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :email_verified, :image_url
end
