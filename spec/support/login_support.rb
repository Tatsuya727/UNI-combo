module LoginSupport

    def login_in_login_page(user)
        fill_in "session[email]",    with: user.email
        fill_in "session[password]", with: user.password
        click_button "ログイン"
    end

    def login(user)
        post login_path, params: { session: { email:    user.email,
                                              password: user.password} }
    end
end