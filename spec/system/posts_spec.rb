require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#root" do
    it "ホームを表示" do
      visit root_path
      expect(page.status_code).to eq(200)
    end
  end

  describe "リンクのテスト" do
    before do
      visit root_path
    end

    describe "#root" do
      it "logo" do
        expect(page).to have_link "UNICombo", href: "/"
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
