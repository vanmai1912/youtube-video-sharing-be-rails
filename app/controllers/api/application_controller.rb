module Api
  class ApplicationController < ActionController::API
    before_action :authenticate_request

    attr_reader :current_user

    private

    def authenticate_request
      token = request.headers['Authorization']&.split(' ')&.last
      decoded_token = TokenService.decode(token)

      if decoded_token
        @current_user = User.find_by(id: decoded_token['user_id'])
        render json: { error: 'User not found' }, status: :unauthorized unless @current_user
      else
        render json: { error: 'Invalid or expired token' }, status: :unauthorized
      end
    end
  end
end
