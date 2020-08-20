class Item < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :ratings, dependent: :destroy
    has_and_belongs_to_many :orders
    validates :title, :description, :category, presence: true
    validates :category, inclusion: { in: %w(tech food wears),
    message: "%{value} is not a valid category" }
    validates_numericality_of :price, :message=>"The Price must be of type number"
end
