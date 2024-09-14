# app/services/token_service.rb
require 'jwt'

class TokenService
  SECRET_KEY = ENV['SECRET_KEY']
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)
    decoded_token.first
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
