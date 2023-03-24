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

    it "logo=>root" do
      expect(page).to have_link "UNICombo", href: root_path
    end
    
    it "signup" do
      expect(page).to have_link "Sign Up", href: signup_path
    end
  end
end
