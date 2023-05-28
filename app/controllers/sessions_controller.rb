class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated? # メアドに送られたリンクをクリックすると
        forwarding_url = session[:forwarding_url] # アクセスしようとしたURLを保存
        reset_session
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        log_in user
        redirect_to forwarding_url || user
      else
        message  = "アカウントが登録できませんでした。"
        message += "あなたのメールアドレスに送られたリンクをもう一度確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
