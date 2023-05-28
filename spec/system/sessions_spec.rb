require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end
  let(:user) { FactoryBot.create(:user) }

  describe "ログイン" do
    before do
      visit login_path
    end
    
    describe "#new" do
      it "ログインページ" do
        expect(page.status_code).to eq(200)
      end

      it "正しいログインフォームが表示されているか" do
        expect(page).to have_field "session[email]"
        expect(page).to have_field "session[password]"
        expect(page).to have_button "ログイン"
        expect(page).to have_link "新規登録", href: signup_path
      end
    end

    describe "#create" do
      context "有効な値の場合" do
        it "ログインが成功する" do
          fill_in "session[email]",    with: user.email
          fill_in "session[password]", with: user.password
          click_button "ログイン"
          expect(current_path).to eq user_path(User.last)
        end
      end

      context "無効な値の場合" do
        it "ログインが失敗する" do
          fill_in "session[email]",    with: ""
          fill_in "session[password]", with: ""
          click_button "ログイン"
          expect(current_path).to eq login_path
          expect(page).to have_content "メールアドレスかパスワードが間違っています。"
          visit root_path
          expect(page).to_not have_content "メールアドレスかパスワードが間違っています。"
        end

        it "パスワードのみ無効な場合" do
          fill_in "session[email]",    with: user.email
          fill_in "session[password]", with: ""
          click_button "ログイン"
          expect(current_path).to eq login_path
          expect(page).to have_content "メールアドレスかパスワードが間違っています。"
          visit root_path
          expect(page).to_not have_content "メールアドレスかパスワードが間違っています。"
        end

        it "メールアドレスのみ無効な場合" do
          fill_in "session[email]",    with: ""
          fill_in "session[password]", with: user.password
          click_button "ログイン"
          expect(current_path).to eq login_path
          expect(page).to have_content "メールアドレスかパスワードが間違っています。"
          visit root_path
          expect(page).to_not have_content "メールアドレスかパスワードが間違っています。"
        end
      end

      context "7回以上ログイン失敗した場合" do
        it "1時間後にリセットされる" do
          7.times do
            fill_in "session[email]",    with: user.email
            fill_in "session[password]", with: "invalid password"
            click_button "ログイン"
          end
          expect(current_path).to eq login_path
        end
      end      
    end
  end

  describe "ログアウト" do
    it "#destroy" do
      visit login_path
      login_in_login_page user
      visit root_path
      expect(page).to have_link "ログアウト"
    end
  end
end
