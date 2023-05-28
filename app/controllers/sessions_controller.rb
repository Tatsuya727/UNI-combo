class SessionsController < ApplicationController
  MAX_LOGIN_ATTEMPTS = 7 # ログイン失敗回数の上限
  RESET_TIME = 1.hour # ログイン失敗回数のリセット時間

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    return account_lock if user && user.login_attempts >= MAX_LOGIN_ATTEMPTS # ログイン失敗回数が上限に達した時ログインを制限

    return login_failed unless user && authenticate_user(user)

    if user.activated? #アカウントが有効化されているかどうか
      login_success(user)
    else
      login_failed
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

    def authenticate_user(user) # ユーザー認証
      if user.authenticate(params[:session][:password])
        reset_login_attempts(user) if too_many_login_attempts?(user)
        true
      else
        increase_login_attempts(user)
        false
      end
    end
  
    def too_many_login_attempts?(user)
      user.login_attempts < MAX_LOGIN_ATTEMPTS && (user.last_attempt_at.nil? || Time.zone.now - user.last_attempt_at > RESET_TIME)
    end

    def reset_login_attempts(user)
      user.update(login_attempts: 0, last_attempt_at: nil)
    end

    def login_success(user)
      forwarding_url = session[:forwarding_url] # アクセスしようとしたURLを保存
      reset_session
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    end

    def login_failed
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "new", status: :unprocessable_entity
    end

    def unactivated_user
      flash[:warning] = "アカウントが登録できませんでした。あなたのメールアドレスに送られたリンクをもう一度確認してください。"
      redirect_to root_url
    end

    def increase_login_attempts(user)
      user.increment!(:login_attempts) # ログイン失敗回数をカウント
      user.update(last_attempt_at: Time.zone.now) if user.login_attempts == 1 # ログイン失敗回数が1回の時に時間を記録
    end

    def account_lock
      flash[:danger] = "ログインに失敗しました。1時間後に再度お試しください。"
      redirect_to root_url and return
    end
end
