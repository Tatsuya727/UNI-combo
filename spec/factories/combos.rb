FactoryBot.define do
    factory :combo do
        title        { "example combo" }
        comando      { "632A > 623C" }
        description  { "説明" }
        situation    { 1 }
        damage       { 3000 }
        hit_count    { 10 }
        character_id { 1 }
        user_id      { 1 }
        created_at   { 10.minutes.ago }
        video_url    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp4')) }

        trait :latest_post do
            created_at { Time.zone.now }
        end
    end
end


def user_with_posts(posts_count: 5)
    FactoryBot.create_list(:combo, posts_count, user_id: 1)
end