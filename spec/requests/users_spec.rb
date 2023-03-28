require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user)       { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:mail)       { UserMailer.account_activation(user) }
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "ログイン" do
    it "remember_meをonにしてログイン" do
      login(user, remember_me: "1")
      expect(cookies[:remember_token].blank?).to_not be_truthy
    end

    it "remember_meをoffにしてログイン" do
      login(user, remember_me: "0")
      expect(cookies[:remember_token].blank?).to be_truthy
    end
  end

  describe "ログアウト" do
    before do
      login user
    end

    it "ログアウトに成功する" do
      delete logout_path
      expect(response).to redirect_to root_path
      follow_redirect!
      delete logout_path
      expect(response).to_not include "ログアウト"
      expect(session[:user_id]).to be_nil
    end
  end

  describe "ユーザーの更新" do
    context "ログインしている場合" do
      before do
        login user
      end
      context "有効な値の場合" do
        before do
          @name  = "hogehoge"
          @email = "foo@bar.com"
          patch user_path(user),  params: { user: { name:  @name,
                                                    email: @email,
                                                    password:              user.password,
                                                    password_confirmation: user.password_confirmation } }
        end
  
        it "更新に成功する" do
          user.reload
          expect(user.name).to  eq @name
          expect(user.email).to eq @email
        end
  
        it "ユーザーページにリダイレクトする" do
          expect(response).to redirect_to user
        end
  
        it "flashが表示されている" do
          expect(flash).to_not be_empty
        end
      end
  
      context "無効な値の場合" do
        it "更新に失敗する" do
          patch user_path(user),  params: { user: { name:                  " ",
                                                    email:                 "foo@invalid",
                                                    password:              "foo",
                                                    password_confirmation: "bar" } }
          user.reload
          expect(user.name).to_not eq " "
          expect(response.body).to include "Update your profile"
        end
      end
    end

    context "ログインしていない場合" do
      it "editにアクセスするとログインページにリダイレクトされる" do
        get edit_user_path(user)
        expect(flash).to_not be_empty
        expect(response).to redirect_to login_path
      end
      
      it "ログインするとeditにリダイレクトされる" do
        get edit_user_path(user)
        login user
        expect(response).to redirect_to edit_user_path(user)
      end

      it "updateにアクセスするとログインページにリダイレクトされる" do
        patch user_path(user),  params: { user: { name:                  user.name,
                                                  email:                 user.email,
                                                  password:              user.password,
                                                  password_confirmation: user.password_confirmation } }
        expect(flash).to_not be_empty
        expect(response).to redirect_to login_path
      end
    end

    context "別のユーザーの場合" do
      before do
        login other_user
      end

      it "editにアクセスするとログインページにリダイレクトされる" do
        get edit_user_path(user)
        expect(flash).to be_empty
        expect(response).to redirect_to root_url
      end

      it "updateにアクセスするとログインページにリダイレクトされる" do
        patch user_path(user),  params: { user: { name:                  user.name,
                                                  email:                 user.email,
                                                  password:              user.password,
                                                  password_confirmation: user.password_confirmation } }
        expect(flash).to be_empty
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "新規登録" do
    let(:user_params) { { user: { name:                  "Example User",
                                  email:                 "user@example.com",
                                  password:              "password",
                                  password_confirmation: "password" } } }
    before do
      ActionMailer::Base.deliveries.clear
    end

    it "メールが送られる" do
      post users_path, params: user_params
      mail_count = ActionMailer::Base.deliveries.size
      expect(mail_count).to eq 1
    end

    it "メールのリンクを開く前はまだ登録されていない" do
      post users_path, params: user_params
      expect(User.last).to_not be_activated
    end
  end
end
