module SessionsHelper

    def log_in(user) # 引数に渡されたユーザーでログインする
        session[:user_id] = user.id
    end

    def remember(user) # 永続セッションのためにユーザーをデータベースに記憶する
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token]    = user.remember_token
    end

    def current_user # ログイン中のユーザーを返す
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in? # ユーザーのログイン状態をtrue,falseで返す
        !current_user.nil?
    end

    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget current_user
        reset_session
        @current_user = nil
    end
end