class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages
  before_action :redirect_if_authenticated

  def new
    @user = User.new
    @user.build_user_account
  end

  def create
    @user = User.new(user_params)
    @user.user_account.role = "user" unless @user.user_account.nil?
    @user.avatar_url = Unsplash.new.random_photo if @user.valid?

    if @user.save
      redirect_to new_session_path, notice: "Usuario registrado con éxito"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :lastname, :email, :phone, :gender, :birth_date,
      user_account_attributes: [ :username, :password, :confirm_password ]
    )
  end
end
