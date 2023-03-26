require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end
  let(:user) { FactoryBot.create(:user) }

  describe "valid signup form" do
    before do
      visit signup_path
    end

    it "valid form" do
      expect(page).to have_field  "user[name]"
      expect(page).to have_field  "user[email]"
      expect(page).to have_field  "user[password]"
      expect(page).to have_field  "user[password_confirmation]"
      expect(page).to have_button "アカウントを作成"
    end
  end

  describe "sign up" do
    before do
      visit signup_path
    end

    it "アカウント作成成功" do
      fill_in "user[name]",                  with: "hoge"
      fill_in "user[email]",                 with: "fooa@hogehoge.com"
      fill_in "user[password]",              with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      count = User.count
      click_button "アカウントを作成"
      expect(User.count).to eq (count + 1)
      expect(current_path).to eq user_path(User.last)
    end

    it "アカウント作成失敗" do
      fill_in "user[name]",                  with: ""
      fill_in "user[email]",                 with: "foo@hogehoge.com"
      fill_in "user[password]",              with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      click_button "アカウントを作成"
      expect(page).to have_http_status(422)
      expect(page).to have_content "Name can't be blank"
      expect(current_path).to eq "/users"
    end
  end

  describe "ユーザーの編集" do
    before do
      visit login_path
      login_in_login_page(user)
      visit edit_user_path(user)
    end

    context "有効な値の場合" do
      it "更新に成功する" do
        expect(current_path).to eq edit_user_path(User.last)
        name  = "hogehoge"
        email = "foo@bar.com"
        fill_in "user[name]",                  with: name
        fill_in "user[email]",                 with: email
        fill_in "user[password]",              with: user.password
        fill_in "user[password_confirmation]", with: user.password_confirmation
        click_button "プロフィールを変更する"
        expect(current_path).to eq user_path(User.last)
      end
    end

    context "無効な値の場合" do
      it "更新に失敗する" do
        expect(current_path).to eq edit_user_path(User.last)
        fill_in "user[name]",                  with: " "
        fill_in "user[email]",                 with: user.email
        fill_in "user[password]",              with: user.password
        fill_in "user[password_confirmation]", with: user.password_confirmation
        click_button "プロフィールを変更する"
        expect(page).to have_http_status(422)
        expect(page).to have_content "Name can't be blank"
        # expect(current_path).to eq edit_user_path(User.last)
      end
    end
  end
end
