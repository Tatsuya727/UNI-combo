require 'rails_helper'

RSpec.describe "Combos", type: :system do
  before do
    driven_by(:rack_test)
  end
  let!(:user)  { FactoryBot.create(:user) }

  describe "ユーザーページ" do
    before do
      FactoryBot.send(:user_with_posts, posts_count: 70)
      @user = Combo.first.user
      visit user_path(@user)
    end

    it "1ページに25個まで表示されている" do
      one_page_posts =
        within "ol.combos" do
          find_all("li")
        end
      expect(one_page_posts.size).to eq 25
    end

    it "ページネーションのボタンが表示されている" do
      expect(page).to have_selector "ul.pagination"
    end

    xit "投稿の中身　後で" do
    end
  end
end
