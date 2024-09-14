class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def generate_token
    payload = { user_id: self.id }
    TokenService.encode(payload)
  end
end
