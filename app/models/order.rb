class Order < ApplicationRecord
    has_and_belongs_to_many :items
    belongs_to :user
end
