require "jwt"

class Authentication::DecodeToken
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def call
    return nil unless token.present?

    encoded_token = JWT::EncodedToken.new(token)
    encoded_token.verify!(signature: { algorithm: "HS256", key: secret_key })
    User.find_by(id: encoded_token.payload["sub"])
  rescue JWT::ExpiredSignature, JWT::VerificationError
    nil
  end

  private

  def secret_key
    ENV["JWT_SECRET_KEY"]
  end
end
