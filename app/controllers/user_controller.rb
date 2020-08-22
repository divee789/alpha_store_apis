class UserController < ApplicationController
  before_action :authorize_admin_request, only: :index
  before_action :authorize_request
  skip_before_action :authorize_request, only: [:create, :index]

  def index
    @users = User.includes(:items)
    render json: @users
  end
   
   def show
    render json: current_user
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
    json_response({ message: 'User Update Successful' })
   end
   
   def delete
    current_user.destroy
    json_response({ message: 'User Removal Successful' })
   end

   def verify_email
     if email_param[:email_verification_token] != current_user.email_verification_token
      json_response({message: 'Email Verification Unsuccessful' })
     else
      current_user.email_verified = true
      current_user.save()
      json_response({ message: 'Email Verification Successful' })
     end
   end

   def upload_image
     response = Cloudinary::Uploader.upload(params[:image], options = {
      folder: 'alpha_store/users',
      width: 1000,
      height: 500,
      crop: 'limit',
      public_id: "user-#{@user.email}-#{@user.id}",
      })
      current_user.update(:image_url => response["url"])
      json_response({ message: 'User image uploaded successfuly' })
    end

   private

   def user_param
    params.require(:user).permit(:first_name, :last_name, :email, :image_url)
   end

   def user_params
    params.permit(:first_name, :last_name, :email, :password)
   end

   def email_param
    params.require(:user).permit(:email_verification_token)
   end
end
