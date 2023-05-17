require 'rails_helper'

RSpec.describe 'Comments', type: :request do
    let!(:user)       { create(:user) }
    let!(:combo)      { create(:combo) }
    let!(:comment)    { create(:comment, user: other_user, combo: combo) }
    let(:other_user) { create(:other_user) }

    
    describe '#create' do
        context "ログイン済みの場合" do
            before do
                login user
            end
            context "正しい値の場合" do
                it "投稿できる" do
                    expect {
                        post combo_comments_path(combo), params: { comment: { body: "example comment" } }
                    }.to change(Comment, :count).by(1)
                end

                it "投稿したコンボ詳細ページにリダイレクト" do
                    post combo_comments_path(combo), params: { comment: { body: "example comment" } }
                    expect(response).to redirect_to combo_path(combo)
                end

                it "正しいレスポンスが返ってくる" do
                    post combo_comments_path(combo), params: { comment: { body: "example comment" } }
                    expect(response).to have_http_status "302"
                end
            end

            context "不正な値の場合" do
                it "投稿できない" do
                    expect {
                        post combo_comments_path(combo), params: { comment: { body: "" } }  
                    }.to_not change(Comment, :count)
                end

                it "投稿に失敗したページにリダイレクト" do
                    post combo_comments_path(combo), params: { comment: { body: "" } }
                    expect(response).to redirect_to combo_path(combo)
                end

                it "正しいレスポンスが返ってくる" do
                    post combo_comments_path(combo), params: { comment: { body: "" } }
                    expect(response).to have_http_status "302"
                end
            end
        end

        context "ログインしていない場合" do
            it "投稿できない" do
                expect {
                    post combo_comments_path(combo), params: { comment: { body: "example comment" } }
                }.to_not change(Comment, :count)
            end
        end
    end

    describe '#destroy' do
        before do
            login other_user
        end

        it "コメントを削除できる" do
            expect {
                delete combo_comment_path(combo, comment)
            }.to change(Comment, :count).by(-1)
        end
    end
end
