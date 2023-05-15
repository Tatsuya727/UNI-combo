require "rails_helper"

RSpec.describe "Combos", type: :request do
    let!(:user)  { FactoryBot.create(:user) }
    let!(:situations) { create_list(:situation, 3) }
    let(:combo)  { FactoryBot.create(:combo) }
    
    describe "#create" do
        let(:valid_params) do
            { 
                combo: {
                    title:        Faker::Lorem.sentence,
                    comando:      Faker::Lorem.sentence,
                    description:  Faker::Lorem.sentence,
                    damage:       1000,
                    hit_count:    10,
                    character_id: 2,
                    situation:    situations.map(&:id),
                    video_url:    Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "fixtures", "files", "sample.mp4"))
                }
            }
        end
        let(:invalid_params) do
            { 
                combo: {
                    title:        "",
                    comando:      Faker::Lorem.sentence,
                    description:  Faker::Lorem.sentence,
                    damage:       1000,
                    hit_count:    10,
                    character_id: 2,
                    situation:    situations.map(&:id),
                    video_url:    Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "fixtures", "files", "sample.mp4"))
                }
            }
        end
        context "未ログインの場合" do
            it "投稿できない" do
                expect {
                    post combos_path, params: valid_params, xhr: true
                }.to_not change(Combo, :count)
            end

            it "ログインページにリダイレクト" do
                post combos_path params: valid_params
                expect(response).to redirect_to login_path
            end
        end

        context "ログイン済みの場合" do
            before do
                login user
            end
            context "正しい値の場合" do
                it "投稿できる" do
                    expect {
                        post combos_path, params: valid_params
                    }.to change(Combo, :count).by(1)
                end

                it "正しいレスポンスが返ってくる" do
                    post combos_path, params: valid_params
                    expect(response).to have_http_status(302)
                end

                it "正しいリダイレクト先に飛ぶ" do
                    post combos_path, params: valid_params
                    expect(response).to redirect_to root_path
                end
            end

            context "不正な値の場合" do
                it "投稿できない" do
                    expect {
                        post combos_path, params: invalid_params
                    }.to_not change(Combo, :count)
                end

                it "正しいレスポンスが返ってくる" do
                    post combos_path, params: invalid_params
                    expect(response).to have_http_status(422)
                end
            end
        end
    end
end