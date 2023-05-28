class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated? # メアドに送られたリンクをクリックすると
        if user.login_attempts < 7 || Time.zone.now - user.last_attemts_at > 1.hour # 7回以上ログイン失敗したら1時間後にリセット
          user.update(login_attempts: 0, last_attemts_at: nil)
          forwarding_url = session[:forwarding_url] # アクセスしようとしたURLを保存
          reset_session
          params[:session][:remember_me] == "1" ? remember(user) : forget(user)
          log_in user
          redirect_to forwarding_url || user
        else
          flash.now[:danger] = "ログインに失敗しました。1時間後に再度お試しください。"
          redirect_to root_url
        end
      else
        message  = "アカウントが登録できませんでした。"
        message += "あなたのメールアドレスに送られたリンクをもう一度確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      user&.increment!(:login_attempts) # ログイン失敗回数をカウント
      user&.update(last_attemts_at: Time.zone.now) if user&.login_attempts == 1 # ログイン失敗回数が1回の時に時間を記録
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
