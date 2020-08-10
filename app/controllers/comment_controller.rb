class CommentController < ApplicationController
    
    def index
        @item = Item.find(params[:item_id])
        @comments = @item.comments.includes(:user)
        json_response(@comments)
    end

    def create
        @item = Item.find(params[:item_id])
        @comment = @item.comments.create!(comment_params.merge(:user_id => current_user.id))
        json_response(@comment, :created)
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
end
