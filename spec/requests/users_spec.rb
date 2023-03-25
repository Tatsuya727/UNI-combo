require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
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
      expect(response).to_not include "ログアウト"
      expect(session[:user_id]).to be_nil
    end
  end

end
