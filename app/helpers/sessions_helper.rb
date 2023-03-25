module SessionsHelper

    def log_in(user) # 引数に渡されたユーザーでログインする
        session[:user_id] = user.id
    end

    def current_user # ログイン中のユーザーを返す
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in? # ユーザーのログイン状態をtrue,falseで返す
        !current_user.nil?
    end

    def log_out
        reset_session
        @current_user = nil
    end
end