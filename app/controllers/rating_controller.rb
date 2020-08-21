class RatingController < ApplicationController

    def rate_item
        @rating = @item.ratings.create(rating_params.merge(:user_id => current_user.id))
        json_response({ message: 'Item rated successfully' })
    end

    def get_item_ratings
        @ratings = @item.ratings.includes(:user)
        render json: @ratings
    end

    private

    def rating_params
        params.permit(:rating)
    end

end
