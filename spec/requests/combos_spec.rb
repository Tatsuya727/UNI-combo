require 'rails_helper'

RSpec.describe "Combos", type: :request do
    let!(:user)  { FactoryBot.create(:user) }
    let(:combo)  { FactoryBot.create(:combo) }

    @test_combo = { title:        Faker::Lorem.sentence,
                    comando:      Faker::Lorem.sentence,
                    description:  Faker::Lorem.sentence,
                    situation:    1,
                    damage:       1000,
                    hit_count:    10,
                    character_id: 2,
                    video_url:    Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp4'))}

    describe "#create" do
        context "未ログインの場合" do
            it "投稿できない" do
                expect {
                    post combos_path, params: @test_combo
                }.to_not change(Combo, :count)
            end

            it "ログインページにリダイレクト" do
                post combos_path params: @test_combo
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
                        post combos_path, params: combo
                    }.to change(Combo, :count).by(1)
                end
            end
        end
    end
end