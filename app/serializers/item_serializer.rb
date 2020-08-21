class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :price, :category
  belongs_to :user
  has_many :comments
  has_many :ratings
end
