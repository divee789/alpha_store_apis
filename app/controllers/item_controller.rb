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

    end

    def update
       @item = Item.find(params[:id])
       @item.update(item_params)
       head :no_content
    end

    private

    def item_params
      params.permit(:title, :description, :price, :image_url)
    end
end
