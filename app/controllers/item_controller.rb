class ItemController < ApplicationController
    before_action :authorize_request
    before_action :find_item, only: [:show, :update, :delete, :rate_item, :get_item_ratings, :upload_image]
    skip_before_action :authorize_request, only: [:index, :show]

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

    def upload_image
        response = Cloudinary::Uploader.upload(params[:image], options = {
        folder: 'alpha_store/items',
        width: 1000,
        height: 500,
        crop: 'limit',
        public_id: "item-#{@item.created_at}-#{@item.id}",
        })
        @item.update(:image_url => response["url"])
        json_response({ message: 'Item image uploaded successfuly' })
    end
    
    def rate_item
        @rating = @item.ratings.create(rating_params.merge(:user_id => current_user.id))
        json_response({ message: 'Item rated successfully' })
    end

    def get_item_ratings
        @ratings = @item.ratings.includes(:user)
        render json: @ratings
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
