module JwtConcern
    extend ActiveSupport::Concern
    


    def jwt_token(payload)
        JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
    end

    
    
end