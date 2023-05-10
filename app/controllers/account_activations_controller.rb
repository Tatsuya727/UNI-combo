class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by(email: params[:email])
        token = params[:id]
        puts "User found: #{user.inspect}"
        puts "Token: #{token}"
        puts "User activation state: #{user.activated?}" if user
        puts "Token match: #{user.authenticated?(:activation, token)}" if user
        token = params[:id]
        if user && !user.activated? && user.authenticated?(:activation, token)
            user.activate
            log_in user
            flash[:success] = 'アカウントが登録されました'
            redirect_to user
        else
            flash[:danger] = 'リンクが正しくありません'
            redirect_to root_url
        end
    end
end
