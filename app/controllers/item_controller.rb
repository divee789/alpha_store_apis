class ItemController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show]

    def index
        @items = Item.all
        json_response(@items)
    end

    def create
        @item = current_user.items.create!(item_params)
        json_response(@item, :created)
    end

    def show
       @item = Item.find(params[:id])
       json_response(@item)
    end

    def update
       @item = Item.find(params[:id])
       @item.update(item_params)
       json_response(@item)
    end

    def delete
        @item = Item.find(params[:id])
        @item.destroy
        json_response({ message: 'Item deleted successfuly' })
    end

    private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url)
    end
end
