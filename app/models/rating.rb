class Rating < ApplicationRecord
    belongs_to :item
    belongs_to :user

    validates_presence_of :rating
end
