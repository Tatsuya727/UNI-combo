require 'rails_helper'

RSpec.describe "Combos", type: :system do
  before do
    driven_by(:rack_test)
  end
  let!(:user)       { FactoryBot.create(:user) }
  let!(:character)  { FactoryBot.create(:character) }
  let!(:situation)  { FactoryBot.create(:situation) }


  describe "投稿ページ" do
    before do
      visit login_path
      login_in_login_page user
      visit new_combo_path
    end

    it "投稿に成功する" do
      fill_in "combo[title]",       with: "title"
      find("#combo_character_id").find("option[value='1']").select_option
      fill_in "combo[damage]",      with: 1
      fill_in "combo[hit_count]",   with: 1
      fill_in "combo[comando]",     with: "comando"
      fill_in "combo[description]", with: "description"
      attach_file("combo[video_url]", "#{Rails.root}/spec/fixtures/files/sample.mp4")
      click_button "投稿する"
      change(Combo, :count).by 1

      expect(page).to have_content "投稿完了"
    end

    it "投稿に失敗する" do
      fill_in "combo[title]",       with: ""
      find("#combo_character_id").find("option[value='1']").select_option
      fill_in "combo[damage]",      with: ""
      fill_in "combo[hit_count]",   with: ""
      fill_in "combo[comando]",     with: ""
      fill_in "combo[description]", with: ""
      attach_file("combo[video_url]", "#{Rails.root}/spec/fixtures/files/sample.mp4")
      click_button "投稿する"
      change(Combo, :count).by 0
      
      expect(page).to have_content "入力しなければならない欄"
    end
  end
end
