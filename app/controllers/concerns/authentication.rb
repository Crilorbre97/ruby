module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user

    private

    def set_current_user
      pp Authentication::DecodeToken.new(session[:token]).call
    end
  end
end
