class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_amount, :total_items, :billing_address, :delivery_date, :processed
  belongs_to :user
end
