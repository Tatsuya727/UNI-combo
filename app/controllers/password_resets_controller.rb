class PasswordResetsController < ApplicationController
  before_action :get_user,           only: [:edit, :update]
  before_action :valid_user,         only: [:edit, :update]
  before_action :check_expiration,   only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "入力されたメールアドレスに送られたリンクを確認してください。"
      redirect_to root_url
    else
      flash.now[:danger] = "このメールアドレスは登録されていません"
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "パスワードが空欄です")
      render "edit", status: :unprocessable_entity
    elsif @user.update(user_params)
      reset_session
      log_in @user
      flash[:success] = "パスワードを変更しました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
            redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "リンクの期限が切れています。2時間以内に行ってください。"
      redirect_to new_password_reset_url
    end
  end
end