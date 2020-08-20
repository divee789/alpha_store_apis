class CommentController < ApplicationController
    
    def index
        @item = Item.find(params[:item_id])
        @comments = @item.comments.includes(:user)
        @response = @comments.map do |record|
          record.attributes.merge(
           'user' => record.user
          )
         end
        json_response(@response)
    end

    def create
        @item = Item.find(params[:item_id])
        @comment = @item.comments.create!(comment_params.merge(:user_id => current_user.id))
        @created_comment = Comment.where({:id => @comment.id}).includes(:user)
        @response = @created_comment.map do |record|
          record.attributes.merge(
           'user' => record.user
          )
         end
        json_response(@response, :created)
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
