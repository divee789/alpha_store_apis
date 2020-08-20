class ItemController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show]

    def index
        @items = Item.includes(:comments, :user)
        @response = @items.map do |record|
          record.attributes.merge(
           'comments' => record.comments,
           'user' => record.user
        )
        end
        json_response(@response)
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

    def rate_item
        @item = Item.find(params[:id])
        @rating = @item.ratings.create(rating_params.merge(:user_id => current_user.id))
        json_response({ message: 'Item rated successfully' })
    end

    def get_item_ratings
        @item = Item.find(params[:id])
        @ratings = @item.ratings.includes(:user)
        @response = @ratings.map do |record|
          record.attributes.merge(
           'user' => record.user
         )
        end
        json_response(@response)
    end

    private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category)
    end

    def rating_params
        params.permit(:rating)
    end
end
