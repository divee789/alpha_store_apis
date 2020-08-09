class Item < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates_presence_of :title
    validates_presence_of :description
    validates_numericality_of :price, :message=>"The Price must be of type number"
end
