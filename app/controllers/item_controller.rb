class ItemController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show]
    before_action :find_item, only: [:show, :update, :delete, :rate_item, :get_item_ratings]

    def index
        @items = Item.all
        render json: @items
    end

    def create
        @item = current_user.items.create!(item_params)
        render json: @item
    end

    def show
      render json: @item
    end

    def update
       @item.update(item_params)
       render json: @item
    end

    def delete
        @item.destroy
        json_response({ message: 'Item deleted successfuly' })
    end

    def show_user_items
       @item = current_user.items.all
       render json: @item
    end

    private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category)
    end

    def rating_params
        params.permit(:rating)
    end

    def find_item
        @item = Item.find(params[:id])
    end
end
