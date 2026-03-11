module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    before_action :protect_pages

    private

    def set_current_user
      Current.user = Authentication::DecodeToken.new(session[:token]).call if session[:token]
    end

    def protect_pages
      redirect_to new_session_path unless Current.user
    end
  end
end
