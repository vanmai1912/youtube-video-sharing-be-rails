class AuthController < Api::ApplicationController
  skip_before_action :authenticate_request, only: [:login, :register]

  def login
    auth_service = AuthService.new(email: params[:email], password: params[:password])
    user = auth_service.login

    if user.is_a?(User)
      token = user.generate_token
      data = {
        user: UserSerializer.new(user).as_json,
        token: token
      }
      render json: {
        data: data,
        status: :ok
      }, status: :ok
    else
      render json: { error: user, status: :unauthorized }, status: :unauthorized
    end
  end

  def register
    auth_service = AuthService.new(
      email: params[:email],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name]
    )
    user = auth_service.register

    if user.is_a?(User)
      render json: { message: 'Đăng ký thành công', status: :ok }, status: :created
    else
      render json: {
        error: user.full_messages.join(', '),
        status: :unprocessable_entity
      }, status: :unprocessable_entity
    end
  end
end
