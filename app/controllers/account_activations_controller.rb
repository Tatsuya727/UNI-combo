class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by(email: params[:email])
        token = params[:id]
        token = params[:id]
        if user && !user.activated? && user.authenticated?(:activation, token)
            user.activate
            log_in user
            flash[:success] = 'アカウントが登録されました'
            redirect_to root_url
        else
            flash[:danger] = 'リンクが正しくありません'
            redirect_to root_url
        end
    end
end
