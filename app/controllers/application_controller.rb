class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include SetLocale
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    Current.user
  end
end
