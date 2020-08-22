class ApplicationController < ActionController::API

    include Response
    include ExceptionHandler

    # called before every action on controllers
    attr_reader :current_user
    attr_reader :current_admin

    private

    # Check for valid request token and return user
    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def authorize_admin_request
      @current_admin = (AuthorizeApiRequest.new(request.headers).call_admin)[:admin]
    end
end
