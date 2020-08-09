class CommentController < ApplicationController
    
    def index
        puts params[:item_id]
        @item = Item.find(params[:item_id])
        @comments = @item.comments.all
        json_response(@comments)
    end

    def create
        @item = Item.find(params[:item_id])
        @comment = @item.comments.create!({body:comment_params.body, user_id: current_user.id})
        json_response(@comment, :created)
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
