class Order < ApplicationRecord
    has_and_belongs_to_many :items
    belongs_to :user
    validates_presence_of :total_amount, :total_items, :billing_address
    validates_numericality_of :total_amount, :total_items
end
