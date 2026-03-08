require "jwt"

class Authentication::JwtService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    JWT.encode(generate_payload, secret_key, "HS256")
  end

  def generate_payload
    {
      user_id: user.id
    }
  end

  def secret_key
    ENV["JWT_SECRET_KEY"]
  end
end
