module LoginSupport

    def login_in_login_page(user)
        fill_in "session[email]",    with: user.email
        fill_in "session[password]", with: user.password
        click_button "ログイン"
    end

    def login(user, remember_me: "1")
        post login_path, params: { session: { email:       user.email,
                                              password:    user.password,
                                              remember_me: remember_me} }
    end

    def is_logged_in?
        !session[:user_id].nil?
    end
end