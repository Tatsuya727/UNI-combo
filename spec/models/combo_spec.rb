require 'rails_helper'

RSpec.describe Combo, type: :model do
    let!(:user)  { FactoryBot.create(:user) }
    let(:combo)  { FactoryBot.create(:combo) }

    describe "バリデーション" do
        it "有効かどうか" do
            expect(combo).to be_valid
        end
        context "presence" do
            it "タイトルがある" do
                combo.title = nil
                expect(combo).to_not be_valid
            end
    
            it "コンボ説明がある" do
                combo.description = nil
                expect(combo).to_not be_valid
            end

            it "コマンドがある" do
                combo.comando = nil
                expect(combo).to_not be_valid
            end
            
            it "ダメージがある" do
                combo.damage = nil
                expect(combo).to_not be_valid
            end
    
            it "ヒット数がある" do
                combo.hit_count = nil
                expect(combo).to_not be_valid
            end
    
            it "character_idがある" do
                combo.character_id = nil
                expect(combo).to_not be_valid
            end
            
            it "user_idがある" do
                combo.user_id = nil
                expect(combo).to_not be_valid
            end
        end

        context "length" do
            it "タイトルは100文字以内" do
                combo.title = "a" * 101
                expect(combo).to_not be_valid
            end

            it "コンボ説明は300文字以内" do
                combo.title = "a" * 301
                expect(combo).to_not be_valid
            end

            it "コマンドは200文字以内" do
                combo.comando = "a" * 201
                expect(combo).to_not be_valid
            end

        end

        context "numericality" do
            it "ダメージは1以上" do
                combo.damage = 0
                expect(combo).to_not be_valid
            end

            it "ダメージは10000以下" do
                combo.damage = 10001
                expect(combo).to_not be_valid
            end

            it "HIT数は1以上" do
                combo.hit_count = 0
                expect(combo).to_not be_valid
            end

            it "HIT数は1000以下" do
                combo.hit_count = 1001
                expect(combo).to_not be_valid
            end
        end
    end

    describe "ソート" do
        it '並び順は投稿の新しい順になっていること' do
            FactoryBot.send(:user_with_posts)
            expect(FactoryBot.create(:combo, :latest_post)).to eq Combo.first
        end
    end

    it "投稿したユーザが削除された場合、そのユーザが今まで投稿したものも削除される" do
        post = FactoryBot.create(:combo, :latest_post)
        user = post.user
        expect{user.destroy}.to change(Combo, :count).by -1
    end
end
