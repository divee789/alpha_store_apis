class UserController < ApplicationController
    skip_before_action :authorize_request, only: :create
   
   def show
     @user = User.find(params[:id])
     json_response(@user)
   end
   
   def create
     @user = User.create!(user_params)
     auth_token = AuthenticateUser.new(@user.email, @user.password).call
     response = { message: Message.account_created, auth_token: auth_token }
     json_response(response, :created)
   end
   
   def update
    @user = User.find(params[:id])
    @user.update(user_param)
    head :no_content
   end
   
   def delete
    User.find(params[:id]).destroy
    head :no_content
   end

   def show_items
    @user = User.find(params[:id])
    @item = @user.items.find_by!(id: params[:id]) if @user
   end

   private

   def user_param
    params.permit(:first_name, :last_name, :email, :image_url, :phone_number)
   end

   def user_params
    params.permit(:first_name, :last_name, :email, :phone_number, :password)
   end
end
