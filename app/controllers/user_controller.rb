class UserController < ApplicationController
  skip_before_action :authorize_request, only: :create
   
   def show
    @user = User.where({:id => current_user.id}).select("id,first_name,last_name,email,image_url,phone_number,twofa_enabled")
    json_response(@user)
   end
   
   def create
     @user = User.create!(user_params)
     @user.email_verification_token = SecureRandom.urlsafe_base64.to_s
     @user.save
     if @user.save
      UserNotifierMailer.send_verification_email(@user.email, @user.email_verification_token).deliver
     end
     token = AuthenticateUser.new(@user.email, @user.password).call
     response = { message: Message.account_created, access_token: token }
     json_response(response, :created)
   end
   
   def update
    current_user.update(user_param)
    head :no_content
   end
   
   def delete
    current_user.destroy
    head :no_content
   end

   def show_items
    @item = current_user.items.all
    json_response(@item)
   end

   private

   def user_param
    params.permit(:first_name, :last_name, :email, :image_url, :phone_number)
   end

   def user_params
    params.permit(:first_name, :last_name, :email, :phone_number, :password)
   end
end
