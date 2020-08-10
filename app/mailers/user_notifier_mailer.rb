
require "sendgrid-ruby"

class UserNotifierMailer < ApplicationMailer
  include SendGrid

   def send_verification_email(email, token)
    from = Email.new(email: 'alphastore@gmail.com')
    to = Email.new(email: "#{email}")
    subject = 'Verification Email'
    content = Content.new(type: 'text/plain', value: "This is your verificaton token. #{token}")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid_api_key)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
   end
end
