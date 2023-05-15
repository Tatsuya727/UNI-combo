require 'rails_helper'

RSpec.describe "Comments", type: :system do
    let!(:user)        { FactoryBot.create(:user) }
    let!(:combo)       { FactoryBot.create(:combo) }
    let!(:character)   { FactoryBot.create(:character) }
    let!(:situation)   { FactoryBot.create(:situation) }
    let!(:comment)     { FactoryBot.create(:comment) }

    before do
        visit login_path
        login_in_login_page user
        visit combo_path(combo)
    end

    describe "#create" do
        it "コメントに成功する" do
            fill_in "comment[body]", with: "example comment"
            click_button "コメントを投稿"
            change(Comment, :count).by 1

            expect(page).to have_content "コメントを投稿しました"
        end

        it "コメントに失敗する" do
            fill_in "comment[body]", with: ""
            click_button "コメントを投稿"
            change(Comment, :count).by 0

            expect(page).to have_content "コメントの投稿に失敗しました"
        end
    end

    describe "#destroy" do
        it "コメントの削除に成功する" do
            expect(page).to have_content comment.body
            click_link "delete"
            expect(page).not_to have_content comment.body
        end
    end
end
