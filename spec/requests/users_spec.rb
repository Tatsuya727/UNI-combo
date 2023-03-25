require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
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

end
