class ApplicationController < ActionController::Base
    include SessionsHelper    

    private

        # ログイン済みかの確認
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "ログインしていません"
                redirect_to login_url, status: :see_other
            end
        end
end
