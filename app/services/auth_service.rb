class AuthService
  def initialize(email:, password:, first_name: nil, last_name: nil)
    @password = password
    @user = User.find_by(email: email)
    @new_email = email
    @first_name = first_name
    @last_name = last_name
  end

  def login
    return 'User not found' unless @user
    return 'Incorrect password' unless @user.valid_password?(@password)
    return 'Account not confirmed' unless @user.confirmed?

    @user
  end

  def register
    user = User.new(email: @new_email, password: @password, first_name: @first_name, last_name: @last_name)
    if user.save
      user
    else
      user.errors
    end
  end
end
