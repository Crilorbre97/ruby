class Authentication::UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_user_account
  end

  def create
    @user = User.new(user_params)
    @user.user_account.role = "user"

    if @user.save
      redirect_to products_path, notice: "Usuario registrado con éxito"
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
