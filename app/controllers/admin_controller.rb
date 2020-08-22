class AdminController < ApplicationController

    before_action :authorize_admin_request
    skip_before_action :authorize_admin_request, only: :create

    def create
        @admin = Admin.create!(admin_params)
        token = AuthenticateAdmin.new(@admin.email, @admin.password).call
        response = { message: Message.admin_account_created, access_token: token }
        json_response(response, :created)
    end

    def show
        render json: @current_admin
    end

    def update
        @current_admin.update(admin_param)
        json_response({ message: 'Admin Update Successful' })
    end

    def delete
        @current_admin.destroy
        json_response({ message: 'Admin Removal Successful' })
    end

    def upload_image
     response = Cloudinary::Uploader.upload(params[:image], options = {
      folder: 'alpha_store/admins',
      width: 1000,
      height: 500,
      crop: 'limit',
      public_id: "admin-#{@admin.email}-#{@admin.id}",
      })
      current_user.update(:image_url => response["url"])
      json_response({ message: 'User image uploaded successfuly' })
    end

    private

    def admin_params
      params.permit(:first_name, :last_name, :email, :password)
    end
end
