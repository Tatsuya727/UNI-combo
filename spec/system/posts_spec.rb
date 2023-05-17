require 'rails_helper'

RSpec.describe "Posts", type: :system do

  describe "#root" do
    it "ホームを表示" do
      visit root_path
      expect(page.status_code).to eq(200)
    end
  end

  describe "トップページのリンクテスト" do
    before do
      visit root_path
    end

    context "未ログイン" do
      it "logo=>root" do
        expect(page).to have_link "UNICombo", href: root_path
      end
      
      it "#signup" do
        expect(page).to have_link "新規登録", href: signup_path
      end
  
      it "#login" do
        expect(page).to have_link "ログイン", href: login_path
      end
    end

    context "ログイン済" do
      let(:user) { FactoryBot.create(:user) }

      before do
        visit login_path
        login_in_login_page user
        visit root_path
      end
      
      it "#user" do
        expect(page).to have_link "マイページ", href: "/users/#{ user.id }"
      end
    end
  end
end
