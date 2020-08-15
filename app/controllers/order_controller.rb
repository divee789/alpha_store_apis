class OrderController < ApplicationController

    def index
      @orders = Order.all
      json_response(@orders)
    end

    def create
      @order = current_user.orders.create!
      for item in params[:user_order]
         Orderitem.create!(:order_id => @order.id, :item_id => item[:id], :quantity => item[:quantity])
      end
     @response = Orderitem.where({:order_id => @order.id}).includes(:item)
     json_response(@response)
    end

    def show
        @order = Order.find(params[:order_id])
        @items = Orderitem.where({:order_id => @order.id}).includes(:item)
        @response = @items.map do |record|
          record.attributes.merge(
           'item' => record.item
        )
        end
        json_response(@response)
    end

    def show_all_user_orders
        @order = current_user.orders
        json_response(@order)
    end

    private 

    def order_params
        params.permit(:user_order)
    end
end