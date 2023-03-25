require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

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
      fill_in "user[email]",                 with: "fooa@example.com"
      fill_in "user[password]",              with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      count = User.count
      click_button "アカウントを作成"
      expect(User.count).to eq (count + 1)
      expect(current_path).to eq "/users/1"
    end

    it "アカウント作成失敗" do
      fill_in "user[name]",                  with: ""
      fill_in "user[email]",                 with: "foo@example.com"
      fill_in "user[password]",              with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      click_button "アカウントを作成"
      expect(page).to have_http_status(422)
      expect(page).to have_content "Name can't be blank"
      expect(current_path).to eq "/users"
    end
  end
end
