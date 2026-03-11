require "jwt"

class Authentication::GenerateToken
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    token = JWT::Token.new(payload: payload, header: header)
    token.sign!(algorithm: "HS256", key: secret_key)

    token.jwt
  end

  private

  def payload
    {
      sub: user.id,
      exp: 24.hours.from_now.to_i,
      # exp: Time.now.to_i + 60,
      jti: SecureRandom.uuid
    }
  end

  def header
    {
      alg: "HS256",
      typ: "JWT",
      kid: "hmac"
    }
  end

  def secret_key
    ENV["JWT_SECRET_KEY"]
  end
end
