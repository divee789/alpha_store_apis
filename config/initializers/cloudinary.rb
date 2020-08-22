Cloudinary.config do |config|    
   config.cloud_name = "donalpha"   
   config.api_key = Rails.application.credentials.cloudinary_api_key.to_s   
   config.api_secret = Rails.application.credentials.cloudinary_api_secret.to_s
   config.secure = true    
   config.cdn_subdomain = true  
end