class ApplicationController < ActionController::API
    
  def encode_token(payload)
    secret  = "Secret1234"
    JWT.encode(payload, secret)
  end  

  def authenticate
    decoded = ''
    authenticate_or_request_with_http_token do |token, options|
      secret  = "Secret1234"
      decoded = JWT.decode token, secret, true, { algorithm: 'HS256' }
    end
  end

  def save_user_zipcode
    user_decoded = authenticate().reduce(:merge)
    UserZipcode.create([{userEmail: user_decoded["user_email"] , zipcode: params[:id]}])
  end
    
end
