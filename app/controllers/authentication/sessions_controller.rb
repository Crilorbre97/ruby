class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages

  def new
    @session = SessionForm.new
  end

  def create
    @session = SessionForm.new(login_params)

    unless @session.valid?
      render :new, status: :unprocessable_entity
      return
    end

    @user_account = UserAccount.find_by("username = :username", {
      username: login_params[:username]
    })

    if @user_account&.authenticate(login_params[:password])
      token = Authentication::GenerateToken.new(@user_account.user).call
      session[:token] = token
      redirect_to products_path, notice: t(".created")
    else
      redirect_to new_session_path, alert: t(".failed")
    end
  end

  def logout
    session.delete(:token)

    redirect_to products_path
  end

  private

  def login_params
    params.require(:session_form).permit(:username, :password)
  end
end
