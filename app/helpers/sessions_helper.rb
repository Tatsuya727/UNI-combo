module SessionsHelper

    def log_in(user) # 引数に渡されたユーザーでログインする
        session[:user_id] = user.id
        session[:session_token] = user.session_token
    end

    def remember(user) # ユーザーを永続セッションに保存する
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token]    = user.remember_token
    end

    def current_user # ログイン中のユーザーを返す
        if (user_id = session[:user_id])
            user = User.find_by(id: user_id)
            if user && session[:session_token] == user.session_token
                @current_user = user
            end
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

    def current_user?(user)
        user && user == current_user
    end
end