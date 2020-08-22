class OrderController < ApplicationController
   before_action :authorize_request
   skip_before_action :authorize_request, only: [:index, :update]
   before_action :authorize_admin_request, only: [:index, :update]
    

    def index
      @orders = Order.includes(:user)
      render json: @orders
    end

    def create
      @order = current_user.orders.create!(:total_amount => params[:total_amount], :total_items => params[:total_items], :billing_address => params[:billing_address])

      for item in params[:user_order]
         Orderitem.create!(:order_id => @order.id, :item_id => item[:id], :quantity => item[:quantity])
      end

     @order_items = Orderitem.where({:order_id => @order.id}).includes(:item)

     @response = @order_items.map do |record|
          record.attributes.merge(
           'item' => record.item
        )
      end
     json_response(@response)
    end

    def update
        @order = Order.find(params[:id])
        @order.update(order_param)
        json_response({ message: 'Order updated successfully' })
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
      @orders = current_user.orders
      render json: @orders
    end
    

    private 

    def order_params
      params.permit(:user_order, :total_amount, :total_items, :billing_address)
    end

    def order_param
      params.permit(:total_amount, :total_items, :processed, :delivery_date, :billing_address)
    end
end
