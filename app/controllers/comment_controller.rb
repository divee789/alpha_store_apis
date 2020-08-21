class CommentController < ApplicationController

    before_action :find_item, only: [:index, :create]

    def index
        @comments = @item.comments.all
        render json: @comments
    end

    def create
        @comment = @item.comments.create!(comment_params.merge(:user_id => current_user.id))
        render json: @comment
    end

    def delete
        @comment = Comment.find(params[:id])
        @comment.destroy
        json_response({ message: 'Comment deleted successfully' })
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def find_item
        @item = Item.find(params[:item_id])
    end
end
