require 'rails_helper'

describe "Combos API", type: :request do
    describe "POST create" do
        let(:user)       { FactoryBot.create(:user) }
        let(:situations) { create_list(:situation, 3) }
        let(:valid_params) do
            {
                combo: {
                    title:        Faker::Lorem.sentence,
                    comando:      Faker::Lorem.sentence,
                    description:  Faker::Lorem.sentence,
                    situation:    situations.map(&:id),
                    damage:       1000,
                    hit_count:    10,
                    character_id: 2,
                    user_id:      user.id,
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
                    situation:    situations.map(&:id),
                    damage:       1000,
                    hit_count:    10,
                    character_id: 2,
                    user_id:      user.id,
                    video_url:    Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "fixtures", "files", "sample.mp4"))
                }
            }
        end
    
        context "リクエストが有効な場合" do
            before { post "/api/v1/combos", params: valid_params }
    
            it "comboが作成される" do
                expect(response).to have_http_status(201)
                expect(JSON.parse(response.body)["title"]).to eq(valid_params[:combo][:title])
            end
        end
    
        context "リクエストが無効な場合" do
            before { post "/api/v1/combos", params: invalid_params }
    
            it "ステータスコード422が返ってくる" do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe "GET show" do
        let(:combo)      { FactoryBot.create(:combo) }
        let!(:user)       { FactoryBot.create(:user) }
        let!(:situation) { FactoryBot.create(:situation) }

        before { get "/api/v1/combos/#{combo.id}" }

        it "comboが取得できる" do
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)["title"]).to eq(combo.title)
        end
    end
end