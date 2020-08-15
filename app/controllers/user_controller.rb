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
    json_response({ status: true, message: 'User Update Successful' })
   end
   
   def delete
    current_user.destroy
    json_response({ status: true, message: 'User Removal Successful' })
   end

   def verify_email
     if email_param.email_verification_token != current_user.email_verification_token
      json_response({ status: false, message: 'Email Verification Unsuccessful' })
     else
      current_user.email_verified = true
      current_user.save()
      json_response({ status: true, message: 'Email Verification Successful' })
     end
   end

   def show_items
    @item = current_user.items.all
    json_response(@item)
   end

   private

   def user_param
    params.require(:user).permit(:first_name, :last_name, :email, :image_url, :phone_number)
   end

   def user_params
    params.permit(:first_name, :last_name, :email, :phone_number, :password)
   end

   def email_param
    params.require(:user).permit(:email_verification_token)
   end
end
